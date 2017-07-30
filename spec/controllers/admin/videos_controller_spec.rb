require 'rails_helper'
require 'pry'

describe Admin::VideosController do
  it_behaves_like "require_log_in" do
    let(:action) { post :create }
  end

  it_behaves_like "require_admin" do
    let(:action) { post :create }
  end

  let(:small_file) do
    fixture_file_upload('files/test_small.jpg', 'image/jpg')
  end

  let(:large_file) do
    fixture_file_upload('files/test_large.jpg', 'image/jpg')
  end

  it "permits the correct video attributes" do
    set_current_admin
    video_params = Fabricate.attributes_for(:video)
                            .merge(small_cover: small_file,
                                   large_cover: large_file)

    is_expected
      .to permit(:title, :description, :category_id, :small_cover, :large_cover, :url)
      .for(:create, params:  { video: video_params } )
      .on(:video)
  end

  describe "POST create" do
    context "valid inputs" do
      it "creates a new video" do
        set_current_admin
        video_params = Fabricate.attributes_for(:video)
                                .merge(small_cover: small_file,
                                       large_cover: large_file)
        post :create, params: { video: video_params }
        expect(Video.count).to eq 1
      end

      it "sets a success flash" do
        set_current_admin
        video_params = Fabricate.attributes_for(:video)
                                .merge(small_cover: small_file,
                                       large_cover: large_file)
        post :create, params:  { video: video_params }
        is_expected.to set_flash[:success].to be
      end

      it "redirects to the admin home page" do
        set_current_admin
        video_params = Fabricate.attributes_for(:video)
                                .merge(small_cover: small_file,
                                       large_cover: large_file)
        post :create, params: { video: video_params }
        expect(response).to redirect_to admin_homes_path
      end
    end

    context "invalid inputs" do
      it "does not create a video" do
        set_current_admin
        video_params = Fabricate.attributes_for(:video, title: "", description: "")
                                .merge(small_cover: small_file,
                                       large_cover: large_file)
        post :create, params: { video: video_params }
        expect(Video.count).to eq 0
      end

      it "sets an error flash message" do
        set_current_admin
        video_params = Fabricate.attributes_for(:video, title: "", description: "")
                                .merge(small_cover: small_file,
                                       large_cover: large_file)
        post :create, params: { video: video_params }
        is_expected.to set_flash[:danger].to be_present
      end
    end
  end
end
