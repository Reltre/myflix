require 'rails_helper'
require 'pry'

describe Admin::VideosController do
  it_behaves_like "require_log_in" do
    let(:action) { post :create }
  end

  it_behaves_like "require_admin" do
    let(:action) { post :create }
  end

  it "permits the correct video attributes" do
    set_current_admin
    video_params = Fabricate.attributes_for(:video)
    is_expected
      .to permit(:title, :description, :category_id, :small_cover, :large_cover)
      .for(:create, params: video_params)
  end

  describe "POST create" do
    context "valid inputs" do
      it "creates a new video" do
        set_current_admin
        video_params = Fabricate.attributes_for(:video)
        post :create, params:  video_params
        expect(Video.count).to eq 1
      end

      it "sets a success flash" do
        set_current_admin
        video_params = Fabricate.attributes_for(:video)
        post :create, params:  video_params
        is_expected.to set_flash[:success].to be
      end

      it "redirects to the admin home page" do
        set_current_admin
        video_params = Fabricate.attributes_for(:video)
        post :create, params: video_params
        expect(response).to redirect_to admin_homes_path
      end
    end

    context "invalid inputs" do
      it "does not create a video" do
        set_current_admin
        video_params = Fabricate.attributes_for(:video, title: nil, description: nil)
        post :create, params: video_params
        expect(Video.count).to eq 0
      end

      it "sets an error flash message" do
        set_current_admin
        video_params = Fabricate.attributes_for(:video, title: nil, description: nil)
        post :create, params: video_params
        is_expected.to set_flash[:danger].to be
      end
    end
  end
end
