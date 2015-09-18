class MyQueuesController < ApplicationController
  before_action :require_login

  def index
    @my_queues = MyQueue.all
    unless logged_in?
      redirect_to log_in_path
    end
  end
end
