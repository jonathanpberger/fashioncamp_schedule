# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details\
  filter_parameter_logging :password
  before_filter :set_current_event
  helper_method :current_event, :admin?

   def current_event
     set_current_event
   end
  

  protected

  def authorize
    unless admin?
      flash[:error] = "unauthorized access"
      redirect_to '/login'
      false
    end
  end

  def admin?
    session[:password] == 'zahmat1'
  end 

  def is_iphone?
      request.user_agent =~ /(Mobile\/.+Safari)/
  end

  def get_tweet_hash
    chars = ("A".."Z").to_a + ("1".."9").to_a 
    return "#" + TWITTER_PREFIX + Array.new(6, '').collect{chars[rand(chars.size)]}.join
  end
  
  private
  
  def set_current_event
    @current_event ||= Event.find_by_short_name!('bcnyc4')
  end
  
end
