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

    it "redirects to the sign in page with unauthenticated users" do
      get :show, id: video.id
      expect(response).to redirect_to log_in_path
    end
  end

  describe "POST add_review" do

    context "with authenticated user" do
      let(:review) { Fabricate.build(:review, video_id: video.id) }

      before do
        log_in
      end


      it "sets review" do
        post :add_review, id: video.id, rating: review.rating, description: review.description
        expect(assigns(:review)).to be_instance_of(Review)
      end

      it "saves a review" do
        post :add_review, id: video.id, rating: review.rating, description: review.description
        expect(Review.count).to eq(1)
      end

      it "redirects back to show page" do
        post :add_review, id: video.id, rating: review.rating, description: review.description
        expect(response).to redirect_to video_path
      end

      it "set flash for incorrect input" do
        post :add_review, id: video.id, rating: review.rating
        should set_flash[:danger].to "Please enter content for your review."
      end

    end

    context "with unauthenticated user" do
      it "redirects to log in page" do
        review = Fabricate.build(:review, video_id: video.id)
        post :add_review, id: video.id, rating: review.rating, description: review.description
        expect(response).to redirect_to log_in_path
      end
    end

  end
end
