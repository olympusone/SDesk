class AgentsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { render json: AgentDatatable.new(view_context) }
    end
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.new(user_params)

    if @agent.save
      redirect_to agents_path, notice: t('.success', value: @agent.fullname)
    else
      render :new
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

    if update_resource(@agent, user_params)
      redirect_to users_path, notice: t('.success', value: @agent.fullname)
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
  def user_params
    # TODO ean to role einai :user tote na dinei sigkekrimena attributes, oxi ola
    params.require(:user).permit(:name, :lastname, :username, :dob, :avatar, :role, :confirmed, :locked,
                                 :password_confirmation, :email, :password, :country, :timezone, :gender,
                                 identities_attributes:[:id, :_destroy, :provider, :uid])
  end

  def update_resource(resource, _params)
    if _params[:password].blank?
      resource.update_without_password(_params)
    else
      resource.update_attributes(_params)
    end
  end
end
