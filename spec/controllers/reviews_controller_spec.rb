require 'rails_helper'

describe ReviewsController do
  describe "POST create" do
    context "with authenticated user" do
      let(:video) { Fabricate(:video) }
      let(:user) { Fabricate(:user) }

      before { set_current_user }

      context "with valid inputs" do
        before do
          post :create, params:
            { video_id: video.id, review: Fabricate.attributes_for(:review) }
        end

        it "creats a review" do
          expect(Review.count).to eq(1)
        end

        it "creates a review associated with the video" do
          expect(Review.first.video).to eq(video)
        end

        it "craetes a review associated with the logged in user" do
          expect(Review.first.user).to eq(User.find(session[:user_id]))
        end

        it "redirects back to show page" do
          expect(response).to redirect_to video_path(video)
        end
      end

      context "with invalid input" do
        it "sets video" do
          review = Fabricate.build(:review)
          post :create, params:
            { video_id: video.id, review: { rating: review.rating} }
          expect(assigns(:video)).to eq(video)
        end

        it "sets reviews" do
          review = Fabricate(:review, video: video)
          post :create, params:
            { video_id: video.id, review: { rating: review.rating } }
          expect(assigns(:reviews)).to match_array([review])
        end

        it "does not create a review" do
          review = Fabricate.build(:review)
          post :create,
               params: { video_id: video.id, review: { rating: review.rating } }
          expect(Review.count).to eq(0)
        end

        it "renders the video/show template" do
          review = Fabricate.build(:review)
          post :create, params:
            { video_id: video.id, review: {rating: review.rating} }
          expect(response).to render_template("videos/show")
        end
      end
    end

    it_behaves_like "require_log_in" do
      let(:action) do
        post :create,
             params: {
               video_id: Fabricate(:video),
               review: Fabricate.attributes_for(:review)
             }
      end
    end
  end
end
