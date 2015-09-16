describe ReviewController do
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
