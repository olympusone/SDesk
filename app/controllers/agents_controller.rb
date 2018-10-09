class AgentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  add_breadcrumb I18n.t('activerecord.models.user.other')
  add_breadcrumb I18n.t('activerecord.models.agent.other'), :agents_path

  def index
    respond_to do |format|
      format.html
      format.json { render json: AgentDatatable.new(view_context) }
    end
  end

  def new
    @agent = Agent.new
    render :edit
  end

  def create
    @agent = Agent.new(agent_params)

    if @agent.save
      redirect_to agents_path, notice: t('.success', value: @agent.fullname)
    else
      render :edit
    end
  end

  def show
    @agent = Agent.find(params[:id])
  end

  def edit
    @agent = Agent.find(params[:id])
  end

  def update
    @agent = Agent.find(params[:id])

    if update_resource(@agent, agent_params)
      redirect_to agents_path, notice: t('.success', value: @agent.fullname)
    else
      render :edit
    end
  end

  def destroy
    @agent = Agent.find(params[:id])

    respond_to do |format|
      if @agent.destroy
        message = t('.success', value: @agent.fullname)

        format.html{ redirect_to users_path, notice: message }
        format.js do
          flash.now[:notice] = message
          render 'shared/js/destroy'
        end
      else
        message = t('.error', value: @agent.fullname)
        format.html{ redirect_to users_path, notice: message }
        format.js do
          flash.now[:alert] = message
          render 'shared/js/destroy'
        end
      end
    end
  end

  private
  def agent_params
    params.require(:agent).permit(:name, :lastname, :title, :department_id, user_attributes:[:email, :password, :password_confirmation, :locked, :confirmed])
  end

  def update_resource(resource, _params)
    if _params[:user_attributes][:password].blank?
      _params[:user_attributes].delete(:password)
      _params[:user_attributes].delete(:password_confirmation)
    end

    resource.update_attributes(_params)
  end
end
