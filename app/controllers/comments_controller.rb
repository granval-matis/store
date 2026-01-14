class CommentsController < ApplicationController
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @product
    else
      render 'products/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
