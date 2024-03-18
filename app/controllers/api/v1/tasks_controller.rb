class Api::V1::TasksController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_task, only: %i[show update destroy]

  def index
    # binding.pry
    @tasks = current_api_v1_user.tasks

    render json: @tasks
  end

  def show
    render json: @task
  end

  def create
    @task = current_api_v1_user.tasks.build(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # @task = task.find(params[:id])
    @task.destroy
  end

  private

  def set_task
    @task = current_api_v1_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content)
  end
end
