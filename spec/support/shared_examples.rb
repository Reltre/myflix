module SharedExamples
  shared_examples "require_log_in" do
    it "redirects to the front page" do
      clear_current_user
      action
      expect(response).to redirect_to log_in_path
    end
  end

  shared_examples "require_admin" do
    it "redirects to home path" do
      set_current_user
      action
      expect(response).to redirect_to home_path
    end
  end

  shared_examples "require_token" do
    it "redirects to the expired token page" do
      action
      expect(response).to redirect_to expired_token_path
    end
  end
end
