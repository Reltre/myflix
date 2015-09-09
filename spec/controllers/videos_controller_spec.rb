require 'rails_helper'

describe VideosController do
  before do
    user = Fabricate(:user)
    session[:user_id] = user.id
  end

  describe "GET search" do
    it "assigns @videos" do
      video = Fabricate(:video)
      get :search, q: "#{video.title}"
      expect(assigns(:videos)).to eq([video])
    end

    it "renders the search template" do
      get :search
      expect(response).to render_template(:search)
    end
  end

  describe "GET show" do
    let(:video) { Fabricate(:video) }

    it "assigns @video" do
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "renders the show template" do
      get :show, id: video.id
      expect(response).to render_template(:show)
    end
  end
end
