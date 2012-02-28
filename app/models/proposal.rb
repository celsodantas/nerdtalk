class Proposal < ActiveRecord::Base
	has_many :comments

	def vote_up
		self.votes += 1
	end

	def vote_down
		self.votes -= 1
	end
end
