require 'rails_helper'

describe ReviewsController do
  describe "POST create" do
    context "with authenticated user" do
      let(:video) { Fabricate(:video) }
      let(:user) { Fabricate(:user) }
      let(:log_in) { session[:user_id] = Fabricate(:user).id }

      before do
        log_in
      end
      context "with valid inputs" do
        it "creates a review associated with the video" do
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
          expect(Review.first.video).to eq(video)
        end

        it "craetes a review associated with the logged in user" do
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
          expect(Review.first.user).to eq(User.find(session[:user_id]))
        end

        it "creats a review" do
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
          expect(Review.count).to eq(1)
        end

        it "redirects back to show page" do
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
          expect(response).to redirect_to video_path(video)
        end
      end

      context "with invalid input" do
        # it "set flash for incorrect input" do
        #   review = Fabricate(:review)
        #   post :create, video_id: video.id, review: {rating: review.rating}
        #   should set_flash[:danger].to "Please enter content for your review."
        # end

        it "does not create a review" do
          review = Fabricate.build(:review)
          post :create, video_id: video.id, review: {rating: review.rating}
          expect(Review.count).to eq(0)
        end

        it "renders the video/show template" do
          review = Fabricate.build(:review)
          post :create, video_id: video.id, review: {rating: review.rating}
          expect(response).to render_template("videos/show")
        end

        it "sets video" do
          review = Fabricate.build(:review)
          post :create, video_id: video.id, review: {rating: review.rating}
          expect(assigns(:video)).to eq(video)
        end

        it "sets reviews" do
          review = Fabricate(:review, video: video)
          post :create, video_id: video.id, review: {rating: review.rating}
          expect(assigns(:reviews)).to match_array([review])
        end
      end
    end

    context "with unauthenticated user" do
      it "redirects to log in page" do
        video = Fabricate(:video)
        post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
        expect(response).to redirect_to log_in_path
      end
    end
  end
end
