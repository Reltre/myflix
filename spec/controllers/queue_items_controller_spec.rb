require 'rails_helper'

describe QueueItemsController do
  let(:current_user) { Fabricate(:user) }
  describe "GET my_queue" do


    it "sets queue items to the queue items of the logged in user" do
      session[:user_id] = current_user.id
      video = Fabricate(:video)
      queue_1 = Fabricate(:queue_item,user: current_user, video: video, list_order: 1)
      queue_2 = Fabricate(:queue_item,user: current_user, video: video, list_order: 2)
      get :index
      expect(assigns(:items)).to match_array([queue_1, queue_2])
    end

    it "redirects to log in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to log_in_path
    end
  end

  describe "POST create" do
    let(:video) { Fabricate(:video) }

    it "create a queue item" do
      session[:user_id] = current_user.id
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "redirects to my queue" do
      session[:user_id] = current_user.id
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end

    it "sets flash message upon creation" do
      session[:user_id] = current_user.id
      post :create, video_id: video.id
      should set_flash[:info].to('This video has been added to your queue')
    end

    it "create the queue item that is associated with the video" do
      session[:user_id] = current_user.id
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates the queue item that is associated with the user" do
      session[:user_id] = current_user.id
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(current_user)
    end

    it "is the last video in the queue items list" do
      monk = Fabricate(:video, title: "monk")
      Fabricate(:queue_item, video: monk, user: current_user, list_order: 1)
      session[:user_id] = current_user.id
      post :create, video_id: video.id
      last_video = QueueItem.where(user: current_user, video_id: video.id).first
      expect(last_video.list_order).to eq(2)
    end

    it "does not add the same video twice" do
      session[:user_id] = current_user.id
      Fabricate(:queue_item, video_id: video.id, user: current_user)
      post :create, video_id: video.id
      expect(current_user.queue_items.size).to eq(1)
    end

    it "redirects to log in page with unauthenticated user" do
      post :create, video_id: video.id
      expect(response).to redirect_to log_in_path
    end
  end

  describe "DELETE destroy" do
    it "deletes a queue items" do
      monk = Fabricate(:video, title: "monk")
      item = Fabricate(:queue_item, video: monk, user: current_user, list_order: 1)
      session[:user_id] = current_user.id
      delete :destroy, queue_id: item.id
      expect(QueueItem.count).to eq(0)
    end

    it "redirects to my queue" do
      session[:user_id] = current_user.id
      delete :destroy
      expect(response).to redirect_to my_queue_path
    end

    it "updates the list order of the other queue items" do
      monk = Fabricate(:video, title: "monk")
      futurama = Fabricate(:video, title: "futurama")
      south_park = Fabricate(:video, title: "south_park")
      item_m = Fabricate(:queue_item, video: monk, user: current_user, list_order: 1)
      Fabricate(:queue_item, video: futurama, user: current_user, list_order: 2)
      Fabricate(:queue_item, video: south_park, user: current_user, list_order: 3)
      session[:user_id] = current_user.id
      delete :destroy, queue_id: item_m.id
      item_positions = QueueItem.where(user: current_user).map(&:list_order)
      expect(item_positions).to eq([1,2])
    end
    it "redirects to sign in page for unauthenticated users"
  end
 end
