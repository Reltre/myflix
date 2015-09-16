require 'rails_helper'

describe ReviewsController do
  describe "POST create" do
    context "with authenticated user" do
      let(:video) { Fabricate(:video) }
      let(:review) { Fabricate.build(:review, video_id: video.id) }
      let(:log_in) { session[:user_id] = Fabricate(:user).id }

      before do
        log_in
      end


      it "sets review" do
        post :create, video_id: video.id, review: {review: review.rating, description: review.description}
        expect(assigns(:review)).to be_instance_of(Review)
      end

      it "saves a review" do
        post :create, video_id: video.id, review: {review: review.rating, description: review.description}
        expect(Review.count).to eq(1)
      end

      it "redirects back to show page" do
        post :create, video_id: video.id, review: {review: review.rating, description: review.description}
        expect(response).to redirect_to video_path(video)
      end

      it "set flash for incorrect input" do
        post :create, video_id: video.id, review: {review: review.rating}
        should set_flash[:danger].to "Please enter content for your review."
      end

    end

    context "with unauthenticated user" do
      it "redirects to log in page" do
        video = Fabricate(:video)
        review = Fabricate.build(:review, video_id: video.id)
        post :create, video_id: video.id, review: {review: review.rating, description: review.description}
        expect(response).to redirect_to log_in_path
      end
    end
  end
end
