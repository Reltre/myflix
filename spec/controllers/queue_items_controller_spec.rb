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

    context "with authenticated user" do
      before do
        session[:user_id] = current_user.id
        post :create, video_id: video.id
      end
    
      it { expect(QueueItem.count).to eq(1) }
      it { expect(response).to redirect_to my_queue_path }
      it { should set_flash[:info].to('This video has been added to your queue') }
      it "create the queue item that is associated with the video"
      it "creates the queue item that is associated with the user"
      it "is the last video in the queue items list"
      it "does not add the same video twice" do
        post :create, video_id: video.id
        expect(current_user.queue_items.size).to eq(1)
      end
    end

    context "with unauthenticated user" do
      it "redirects to log in page" do
        post :create, video_id: video.id
        expect(response).to redirect_to log_in_path
      end
    end
  end
end
