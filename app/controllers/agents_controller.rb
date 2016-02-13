class AgentsController < ApplicationController
  before_action :find_request, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search]
      @results = Agent.search(params[:search]).order("created_at DESC")
    else
      @results = Agent.order("request")
    end
    @agents = @results.page(params[:page]).per(7)
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.new agent_params
    if @agent.save
      flash[:notice] = "Request saved successfully"
      redirect_to agent_path(@agent)
    else
      flash[:alert] = "Sorry! Request was not saved"
      render :new
    end
  end

  def show
    # @agent = Agent.find params[:id]
  end

  def edit
  end

  def update
    if @agent.update agent_params
      if agent_params.has_key?(:request)
        # byebug
        redirect_to agents_path, notice: "Support Request has been updated"
      else
        redirect_to agent_path, notice: "Support Request has been updated"
      end
    else
      render :edit
    end
  end

  def destroy
    @agent.destroy
    redirect_to agents_path(@agent), notice: "Request from - #{@agent.name} has been deleted successfully!"
  end

  private

  def agent_params
    agent_params = params.require(:agent).permit([:name, :email, :department, :message, :request])
  end

  def find_request
    @agent = Agent.find params[:id]
  end
end
