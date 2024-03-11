class Api::V1::TodosController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_todo, only: %i[show update destroy]

  def index
    binding.pry
    @todos = current_api_v1_user.todos

    render json: @todos
  end

  def show
    render json: @todo
  end

  def create
    @todo = current_api_v1_user.todos.build(todo_params)
    if @todo.save
      render json: @todo, status: :created
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # @todo = Todo.find(params[:id])
    @todo.destroy
  end

  private

  def set_todo
    @todo = current_api_v1_user.todos.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :content)
  end
end
