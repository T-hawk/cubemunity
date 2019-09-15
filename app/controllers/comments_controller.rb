require 'pp'

class CommentsController < ApplicationController
  def new
    @comment = @signed_in_user.comments.create(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:success] = "Comment successfully saved"
      redirect_to @comment.post
    else
      flash[:danger] = "Comment unsuccessfully saved"
      redirect_to @comment.post
    end
  end

  def comment_params
    pp "Content: #{params[:comment][:content]}"
    params.require(:comment).permit(:content, :post_id)
  end
end
