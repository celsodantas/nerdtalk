class ProposalsController < ApplicationController
  # GET /proposals
  # GET /proposals.json
  def index
    @proposals = Proposal.order("votes desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @proposals }
    end
  end

  # GET /proposals/1
  # GET /proposals/1.json
  def show
    @proposal = Proposal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @proposal }
    end
  end

  # GET /proposals/new
  # GET /proposals/new.json
  def new
    @proposal = Proposal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @proposal }
    end
  end

  # GET /proposals/1/edit
  def edit
    @proposal = Proposal.find(params[:id])
  end

  # POST /proposals
  # POST /proposals.json
  def create
    @proposal = Proposal.new(params[:proposal])

    respond_to do |format|
      if @proposal.save
        flash[:notice] = 'Proposal was successfully created.'
        format.html { redirect_to :action => :index }
        format.json { render :json => @proposal, :status => :created, :location => @proposal }
      else
        format.html { render :action => "new" }
        format.json { render :json => @proposal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /proposals/1
  # PUT /proposals/1.json
  def update
    @proposal = Proposal.find(params[:id])

    respond_to do |format|
      if @proposal.update_attributes(params[:proposal])
        format.html { redirect_to @proposal, :notice => 'Proposal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @proposal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.json
  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy

    respond_to do |format|
      format.html { redirect_to proposals_url }
      format.json { head :no_content }
    end
  end


  before_filter :can_user_vote_up?,   :only => [:vote_up]
  before_filter :can_user_vote_down?, :only => [:vote_down]

  def can_user_vote_up?
    render :cant_vote if cookies[:votes_count].to_i == 3
  end

  def can_user_vote_down?
    render :cant_vote if cookies[:votes_count].to_i == 0
  end

  def vote_up
    cookies[:votes_count] = cookies[:votes_count].to_i + 1

    @proposal = Proposal.find(params[:id])
    @proposal.vote_up

    @proposal.save

    render :vote
  end

  def vote_down
    cookies[:votes_count] = cookies[:votes_count].to_i - 1

    @proposal = Proposal.find(params[:id])
    @proposal.vote_down

    @proposal.save

    render :vote
  end

end
