class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def create
    authorize @project, :comment?
    @project.comment_threads.create(user: current_user, comment: params[:comment][:body])
    redirect_to @project, notice: 'Comment added.'
  end

  private
  def set_project
    @project = Project.find(params[:project_id])
  end
end