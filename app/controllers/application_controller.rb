class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  helper_method :current_user, :current_tournament, :main_score_board

  def current_user
    # Note: we want to use "find_by_id" because it's OK to return a nil.
    # If we were to use User.find, it would throw an exception if the user can't be found.
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  def authenticate
    redirect_to :root unless @current_user.nil?
  end

  def check_admin
    redirect_to :root unless current_user.is_admin?
  end

  def current_tournament
    Tournament.where(is_active: true).first
  end

  def main_score_board
    ScoreBoard.where(tournament_id: current_tournament.id, user_id: nil).first
  end

#  rescue_from Exception, with: lambda { |exception| render_error 500, exception }
#  rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }

  def error_404
    @not_found_path = params[:not_found]
  end

  def error_500

  end

  private
    def render_error(status, exception)
      respond_to do |format|
        format.html { render template: "layouts/error_#{status}", layout: 'layouts/application', status: status }
        format.all { render nothing: true, status: status }
      end
    end
end
