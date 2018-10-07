class AdminsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  add_breadcrumb I18n.t('activerecord.models.user.other')
  add_breadcrumb I18n.t('activerecord.models.admin.other'), :admins_path

  def index
    respond_to do |format|
      format.html
      format.json { render json: AdminDatatable.new(view_context) }
    end
  end

  def new
    @admin = Admin.new
    render :edit
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to admins_path, notice: t('.success', value: @admin.fullname)
    else
      render :edit
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

    if update_resource(@admin, admin_params)
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
  def admin_params
    params.require(:admin).permit(:name, :lastname, :title, user_attributes:[:email, :password, :password_confirmation, :locked, :confirmed])
  end

  def update_resource(resource, _params)
    if _params[:admin][:user_attributes][:password].blank?
      _params[:admin][:user_attributes].delete(:password)
      _params[:admin][:user_attributes].delete(:password_confirmation)

      resource.update_without_password(_params)
    else
      resource.update_attributes(_params)
    end
  end
end
