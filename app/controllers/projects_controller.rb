class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :update]

  def show
    @comments = @project.comment_threads.order(created_at: :desc)
  end

  def index
    @projects = current_user.projects
  end

  def update
    authorize @project, :change_status?
    previous_status = @project.status
    if @project.update(project_params)
      @project.comment_threads.create(user: current_user, comment: "changed status from #{previous_status} to #{@project.status}")
      redirect_to @project, notice: 'Project updated.'
    else
      render :show
    end
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:status)
  end
end

