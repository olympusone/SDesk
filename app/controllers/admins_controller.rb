class AdminsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { render json: AdminDatatable.new(view_context) }
    end
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(user_params)

    if @admin.save
      redirect_to admins_path, notice: t('.success', value: @admin.fullname)
    else
      render :new
    end
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])

    if update_resource(@admin, user_params)
      redirect_to users_path, notice: t('.success', value: @admin.fullname)
    else
      render :edit
    end
  end

  def destroy
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.destroy
        message = t('.success', value: @admin.fullname)

        format.html{ redirect_to users_path, notice: message }
        format.js do
          flash.now[:notice] = message
          render 'shared/js/destroy'
        end
      else
        message = t('.error', value: @admin.fullname)
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
