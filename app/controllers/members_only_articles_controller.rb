class MembersOnlyArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authorize
  def index
    if is_member_only == true 
      article = Article.all 
      render json: article
    else render json: { error: "Not authorized" }, status: :unauthorized
  end
  end

  def show
    article = Article.find(params[:id])
    render json: article
  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end

  def authorize
    
    render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :is_member_only
  end
end
