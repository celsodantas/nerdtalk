class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :generate_cookie_hash, :set_votes_count

  def set_votes_count
   	if cookies[:votes_count].nil?
  		reset_votes_count
  	elsif cookies_has_more_than_a_week(cookies[:votes_age])
  		reset_votes_count
  	end
  end

private

  def reset_votes_count
  	cookies[:votes_count] = 0 
	cookies[:votes_age]	  = Time.now	
  end

  def cookies_has_more_than_a_week(cookie_age)
  	Time.parse(cookie_age) < Time.new.prev_week(:saturday)
  end

  def generate_cookie_hash
    cookies[:hash] = SecureRandom.base64 if cookies[:hash] == nil
  end

end
