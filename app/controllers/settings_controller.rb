class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_settings, only: [:edit, :update]

  def edit

  end

  def update
    settings = setting_params
    settings.each do |key, value|
      Setting[key.to_sym] = value
    end

    redirect_to edit_setting_path, notice: t('.success')
  end

  private
  def get_settings
    @settings = Setting.get_all
  end

  def setting_params
    params.require(:setting).permit!
  end
end