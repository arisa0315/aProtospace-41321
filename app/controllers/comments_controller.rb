class CommentsController < ApplicationController
  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.content.blank?
      @comments = @prototype.comments.includes(:user)
      render 'prototypes/show'
    elsif @comment.save
      redirect_to prototype_path(@prototype), notice: 'コメントが投稿されました。'
    else
      @comments = @prototype.comments.includes(:user)
      render 'prototypes/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to prototype_path(@comment.prototype), notice: 'コメントが削除されました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end