require 'rails_helper'

describe MyQueuesController do
  describe "GET index" do
    it "assigns @my_queues" do
      session[:user_id] = Fabricate(:user).id
      get :index
      expect(assigns(:my_queues)).to eq(MyQueue.all)
    end

    it "redirects to log in page for unauthorized users" do
      get :index
      expect(response).to redirect_to log_in_path
    end
  end
end
