require 'rails_helper'

describe VideosController do
  before { set_current_user }
  let(:video) { Fabricate(:video) }


  describe "GET search" do
    it "assigns @videos for authenticated users" do
      get :search, q: "#{video.title}"
      expect(assigns(:videos)).to eq([video])
    end

    it_behaves_like "require_log_in" do
      let(:action) { get :search }
    end
  end

  describe "GET show" do
    it "assigns @video with authenticated users" do
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "assigns reviews with authenticated users" do
      get :show, id: video.id
      expect(assigns(:reviews)).to eq(video.reviews)
    end

    it_behaves_like "require_log_in" do
      let(:action) { get :show, id: video.id }
    end
  end

end
