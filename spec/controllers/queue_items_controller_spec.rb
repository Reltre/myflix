require 'rails_helper'

describe QueueItemsController do
  before { set_current_user }

  describe "GET " do
    it "sets queue items to the queue items of the logged in user" do
      video = Fabricate(:video)
      queue_1 = Fabricate(:queue_item,user: current_user, video: video, list_order: 1)
      queue_2 = Fabricate(:queue_item,user: current_user, video: video, list_order: 2)
      get :index
      expect(assigns(:items)).to match_array([queue_1, queue_2])
    end

    it_behaves_like "require_log_in" do
      let(:action) { get :index }
    end
  end

  describe "POST create" do
    let(:video) { Fabricate(:video) }

    it "create a queue item" do
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "redirects to my queue" do
      post :create, video_id: video.id
      expect(response).to redirect_to queue_items_path
    end

    it "create the queue item that is associated with the video" do
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates the queue item that is associated with the user" do
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(current_user)
    end

    it "is the last video in the queue items list" do
      monk = Fabricate(:video, title: "monk")
      Fabricate(:queue_item, video: monk, user: current_user, list_order: 1)
      post :create, video_id: video.id
      last_video = QueueItem.where(user: current_user, video_id: video.id).first
      expect(last_video.list_order).to eq(2)
    end

    it "does not add the same video twice" do
      Fabricate(:queue_item, video_id: video.id, user: current_user, list_order: 1)
      post :create, video_id: video.id
      expect(current_user.queue_items.size).to eq(1)
    end

    it_behaves_like "require_log_in" do
      let(:action) { post :create, video_id: video.id }
    end
  end

  describe "DELETE destroy" do
    it "redirects to my queue" do
      monk = Fabricate(:video, title: "monk")
      item = Fabricate(:queue_item, video: monk, user: current_user, list_order: 1)
      delete :destroy, id: item.id
      expect(response).to redirect_to queue_items_path
    end

    it "deletes a queue items" do
      monk = Fabricate(:video, title: "monk")
      item = Fabricate(:queue_item, video: monk, user: current_user, list_order: 1)
      delete :destroy, id: item.id
      expect(QueueItem.count).to eq(0)
    end

    it "does not delete the queue item if the queue item is not in the current user's queue" do
      another_user = Fabricate(:user)
      monk = Fabricate(:video, title: "monk")
      item = Fabricate(:queue_item, video: monk, user: another_user, list_order: 1)
      delete :destroy, id: item.id
      expect(QueueItem.count).to eq(1)
    end

    it "updates the list order of the other queue items" do
      monk = Fabricate(:video, title: "monk")
      futurama = Fabricate(:video, title: "futurama")
      south_park = Fabricate(:video, title: "south_park")
      item_m = Fabricate(:queue_item, video: monk, user: current_user, list_order: 1)
      Fabricate(:queue_item, video: futurama, user: current_user, list_order: 2)
      Fabricate(:queue_item, video: south_park, user: current_user, list_order: 3)
      delete :destroy, id: item_m.id
      item_positions = QueueItem.where(user: current_user).map(&:list_order)
      expect(item_positions).to eq([1,2])
    end

    it "redirects to sign in page for unauthenticated users" do
      clear_current_user
      delete :destroy, id: 3
      expect(response).to redirect_to log_in_path
    end

    it_behaves_like "require_log_in" do
      let(:action) { delete :destroy, id: 3 }
    end
  end

  describe "POST update_queue" do
    context "with valid inputs" do
      let(:monk) { Fabricate(:video) }
      let!(:item_1) do
        Fabricate(:queue_item, video: monk, user: current_user, list_order: 1)
      end
      let!(:item_2) do
        Fabricate(:queue_item, video: monk, user: current_user, list_order: 2)
      end
      let!(:item_3) do
        Fabricate(:queue_item, video: monk, user: current_user, list_order: 3)
      end

      it "redirects to the my queue page if authenticated" do
        post :update_queue, params: { queue_items_data: { list_orders: [], ratings: [] } }
        expect(response).to redirect_to queue_items_path
      end

      it "reorders the queue items" do
        post :update_queue,
             queue_items_data: { :list_orders => [3, 2, 1], :ratings => [] }
        expect(current_user.queue_items).to eq([item_3, item_2, item_1])
      end

      it "normalizes the list order numbers" do
        post :update_queue,
             queue_items_data: { :list_orders => [9, 7, 5], :ratings => [] }
        list_orders = current_user.queue_items.map(&:list_order)
        expect(list_orders).to eq([1, 2, 3])
      end
    end

    context "with invalid inputs" do
      before do
        monk = Fabricate(:video)
        Fabricate(:queue_item, video: monk, user: current_user, list_order: 1)
        Fabricate(:queue_item, video: monk, user: current_user, list_order: 2)
        Fabricate(:queue_item, video: monk, user: current_user, list_order: 3)
      end

      it "redirects to the  page" do
        post :update_queue,
             queue_items_data: { list_orders: [3, 1, false], ratings: [] }
        expect(response).to redirect_to queue_items_path
      end

      it "sets the flash when there is invalid data" do
        post :update_queue,
             queue_items_data: { list_orders:[3, 1, false], ratings: [] }
        should set_flash[:danger].to("One or more of your queue items did not update.")
      end

      it "does not change the queue items" do
        post :update_queue,
             queue_items_data: { list_orders: [3, 1, false], ratings: [] }
        expect( current_user.queue_items.map(&:list_order) ).to eq([1, 2, 3])
      end
    end

    it_behaves_like "require_log_in" do
      let(:action) { post :update_queue }
    end
  end
end
