require 'rails_helper'

describe VideosController do
  describe "GET search" do
    it "assigns @videos" do
      vid = Video.create(title: "video1", description: "worrrk")
      get :search, params: { q: "1" }
      expect(assigns(:videos)).to eq([vid])
    end

    it "renders the search template" do
      get :search
      expect(response).to render_template(:search)
    end

  end
  
  describe "GET show" do
  end
end
