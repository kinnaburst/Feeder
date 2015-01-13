class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include FeedsHelper

  before_action :setup_flash


  private

    def setup_flash
      flash[:notice] ||= []
      flash[:warning] ||= []
    end
end
