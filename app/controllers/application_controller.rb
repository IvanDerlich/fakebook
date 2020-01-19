# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name phone_number])
  end

  def timeline_posts
    @posts = current_user.posts.recent_posts
    @friends = current_user.friends
  end
end
