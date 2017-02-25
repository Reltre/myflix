require 'rails_helper'

describe Admin::HomesController do
  describe "GET index" do
    it "assigns @categories" do
      set_current_admin
      get :index
      expect(assigns(:categories)).to eq Category.all
    end

    it "sets flash danger when the current user isn't an admin" do
      set_current_user
      get :index
      is_expected.to set_flash[:danger].to "You do not have access to that area."
    end

    it_behaves_like "require_log_in" do
      let(:action) { get :index }
    end

    it_behaves_like "require_admin" do
      let(:action) { get :index }
    end
  end
end
