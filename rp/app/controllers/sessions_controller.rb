require 'openid_engine/acts_as_rp'
class SessionsController < ApplicationController
  include OpenidEngine::ActsAsRp
  
  skip_before_filter :login_required
  
  # render new.rhtml
  def new
  end
  
  def show
    openid_authentication if openid_request?
  end
  
  def create
    if openid_request?
      openid_authentication
    else
      password_authentication
    end
  end
  
  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(new_session_path)
  end
  
  private
  def openid_authentication
    authenticate_with_openid do |result, assertion|
      case result
      when :missing   then failed_login "Sorry, the OpenID server couldn't be found"
      when :canceled  then failed_login "OpenID verification was canceled"
      when :failed    then failed_login "Sorry, the OpenID verification failed"
      when :successful
        login_by_openid assertion
      else
        failed_login "Unknown status #{result}"
      end
    end
  end
  
  def login_by_openid(assertion)
    current_user = OpenidAccount.find_by_identity assertion[:identity]
    if current_user
      successful_login
    else
      failed_login "Sorry, no user by that identity URL exists: claimed_id:#{assertion[:claimed_id]}, identity:#{assertion[:identity]}"
    end
  end
  
  def password_authentication
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      successful_login
    else
      failed_login "wrong login or password"
    end
  end
  
  def failed_login(msg)
    flash[:notice] = msg
    render :action => 'new'
  end
  
  def successful_login
    redirect_back_or_default(session_path)
    flash[:notice] = "Logged in successfully"
  end
   
  def openid_authentication_old
    $LOGGER = logger
    process_openid_request(:return_to => session_url) do |openid|
      if openid.authorized?
        current_user = User.find_by_claimed_id openid.claimed_id
      else
        flash[:notice] = openid.messages.join(",")
        render :action => 'new'
      end
    end
  end  
end
