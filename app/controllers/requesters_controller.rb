class RequestersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  add_breadcrumb I18n.t('activerecord.models.requester.other'), :requesters_path

  def index
    respond_to do |format|
      format.html
      format.json { render json: RequesterDatatable.new(view_context) }
    end
  end

  def new
    @requester = Requester.new
    render :edit
  end

  def create
    @requester = Requester.new(requester_params)

    if @requester.user
      @requester.company = Company.find_by_domain @requester.user.email.split('@').last
    end

    if @requester.save
      redirect_to requesters_path, notice: t('.success', value: @requester.fullname)
    else
      render :edit
    end
  end

  def show
    @requester = Requester.find(params[:id])
  end

  def edit
    @requester = Requester.find(params[:id])
  end

  def update
    @requester = Requester.find(params[:id])

    if update_resource(@requester, requester_params)
      redirect_to requesters_path, notice: t('.success', value: @requester.fullname)
    else
      render :edit
    end
  end

  def destroy
    @requester = Requester.find(params[:id])

    respond_to do |format|
      if @requester.destroy
        message = t('.success', value: @requester.fullname)

        format.html{ redirect_to users_path, notice: message }
        format.js do
          flash.now[:notice] = message
          render 'shared/js/destroy'
        end
      else
        message = t('.error', value: @requester.fullname)
        format.html{ redirect_to users_path, notice: message }
        format.js do
          flash.now[:alert] = message
          render 'shared/js/destroy'
        end
      end
    end
  end

  private
  def requester_params
    params.require(:requester).permit(:name, :lastname, :title, :title, :notes,
                                      user_attributes:[:email, :password, :password_confirmation, :locked, :confirmed])
  end

  def update_resource(resource, _params)
    if _params[:user_attributes][:password].blank?
      _params[:user_attributes].delete(:password)
      _params[:user_attributes].delete(:password_confirmation)
    end

    resource.update_attributes(_params)
  end
end
