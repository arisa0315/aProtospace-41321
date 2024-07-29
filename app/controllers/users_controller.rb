class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:show]

  def show
    @prototypes = @user.prototypes.order('created_at DESC')
  end

  private

  def set_user
    if params[:id] != 'sign_out'
      @user = User.find(params[:id])
    else
      redirect_to root_path, alert: 'ユーザーが見つかりません'
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'ユーザーが見つかりません'
  end
end
