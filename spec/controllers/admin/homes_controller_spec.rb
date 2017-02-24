require 'rails_helper'

describe Admin::HomesController do
  describe "GET index" do
    it "assigns @categories" do
      get :index
      expect(assigns(:categories)).to eq Category.all
    end
  end
end
