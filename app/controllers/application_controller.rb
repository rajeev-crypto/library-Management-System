class ApplicationController < ActionController::Base

  def current_user
    if session.include? :user_id
      User.find(session[:user_id])
    end
  end

  def require_login
    redirect_to root_url unless session.include? :user_id
  end

  def require_librarian
    require_login
    user = current_user
    redirect_to root_url unless user.librarian
  end

  def require_standard_user
    require_login
    user = current_user
    redirect_to root_url unless !user.librarian
  end

end