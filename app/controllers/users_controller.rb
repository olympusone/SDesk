class UsersController < ApplicationController
  load_and_authorize_resource :user

  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(view_context) }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.sign_up_terms = true

    if @user.save
      redirect_to users_path, notice: t('.success', value: @user.fullname)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if current_user.role? :user
      render :show_user
    else
      render :show
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if update_resource(@user, user_params)
      redirect_to users_path, notice: t('.success', value: @user.fullname)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.destroy
        message = t('.success', value: @user.fullname)

        format.html{ redirect_to users_path, notice: message }
        format.js do
          flash.now[:notice] = message
          render 'shared/js/destroy'
        end
      else
        message = t('.error', value: @user.fullname)
        format.html{ redirect_to users_path, notice: message }
        format.js do
          flash.now[:alert] = message
          render 'shared/js/destroy'
        end
      end
    end
  end

  def checksession
    render json: {
        balance: current_user.balance
    }
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
