module SharedExamples
  shared_examples "require_log_in" do
    it "redirects to the front page" do
      clear_current_user
      action
      expect(response).to redirect_to log_in_path
    end
  end
end
