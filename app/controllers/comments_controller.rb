require 'pp'

class CommentsController < ApplicationController
  def new
    @comment = @signed_in_user.comments.create(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:success] = "Comment successfully saved"
      redirect_back fallback_location: root_path
    else
      flash[:danger] = "Comment unsuccessfully saved"
      redirect_back fallback_location: root_path
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
