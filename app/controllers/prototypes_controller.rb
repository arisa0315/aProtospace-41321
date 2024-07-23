class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
   # @prototypes = Prototype.order('created_at DESC')
    @prototypes = Prototype.order('created_at ASC') 
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path, notice: 'プロトタイプが作成されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: 'プロトタイプが更新されました。'
    else
      flash.now[:alert] = '入力欄をすべて埋めてください。'
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path, notice: 'プロトタイプが削除されました。'
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def correct_user
    @prototype = current_user.prototypes.find_by(id: params[:id])
    redirect_to root_path, alert: 'アクセス権限がありません' if @prototype.nil?
  end
end
