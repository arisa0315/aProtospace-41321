class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_prototype

  def create
    @comment = @prototype.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to prototype_path(@prototype), notice: 'コメントが投稿されました。'
    else
      @comments = @prototype.comments
      flash.now[:alert] = 'コメントの投稿に失敗しました。'
      render 'prototypes/show'
    end
  end

  def destroy
    @comment = @prototype.comments.find(params[:id])
    @comment.destroy
    redirect_to prototype_path(@prototype), notice: 'コメントが削除されました。'
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:prototype_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end