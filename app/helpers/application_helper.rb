module ApplicationHelper

	def avatar_url(user)
	    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
	    "http://gravatar.com/avatar/#{gravatar_id}.png?s=24"
	end

	def delete_comment_link(proposal, comment)
	  if comment_owner?(comment)
		  link_to "x", [proposal, comment], :confirm => 'Are you sure?', :method => :delete, :remote => true
	  end
	end

	def markdown(text)
	    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :xhtml]
	    RedCloth.new(text).to_html.html_safe
	end
	
	private 
	
	def comment_owner?(comment)
	  comment.owner_hash == cookies[:hash]
  end
end
