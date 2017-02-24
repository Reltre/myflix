class Admin::HomesController < ApplicationController
  def index
    @categories = Category.all
  end
end
