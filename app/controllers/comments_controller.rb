class CommentsController < ApplicationController
  def create
  	@proposal = Proposal.find(params[:proposal_id])
  	@proposal.comments << Comment.new(params[:comment].merge(:owner_hash => cookies[:hash]))

  	redirect_to @proposal
  end

  def destroy
  	@comment = Comment.find(params[:id])
  	@comment.destroy
  end
end
