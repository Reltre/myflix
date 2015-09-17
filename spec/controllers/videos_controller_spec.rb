require 'rails_helper'

describe VideosController do
  let(:log_in) { session[:user_id] = Fabricate(:user).id }
  let(:video) { Fabricate(:video) }


  describe "GET search" do
    it "assigns @videos for authenticated users" do
      log_in
      get :search, q: "#{video.title}"
      expect(assigns(:videos)).to eq([video])
    end

    it "redirects to the sign in page for unauthenticated users" do
      get :search
      expect(response).to redirect_to log_in_path
    end
  end

  describe "GET show" do
    it "assigns @video with authenticated users" do
      log_in
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "assigns reviews with authenticated users" do
      log_in
      get :show, id: video.id
      expect(assigns(:reviews)).to eq(video.reviews)
    end

    it "redirects to the sign in page with unauthenticated users" do
      get :show, id: video.id
      expect(response).to redirect_to log_in_path
    end
  end

end
