class TodosController < ApplicationController
    respond_to :html, :js
before_filter :authenticate_user!, only: [:todos]

  def new
    @todo = Todo.new
  end

  def index
    @todos = current_user.todos
    @todo = Todo.new
  end

  def create
    @todo = current_user.todos.build(todo_params)
    @todo_new = Todo.new

    if @todo.save
      flash[:notice] = 'Your new TODO was saved'
    else
      flash[:error] = 'Please re-enter your TODO.'
    end

    respond_with(@todo) do |format|
      format.html { render :index}
    end

  end

  def destroy
    @todo = current_user.todos.find(params[:id])
    @todo_id = @todo.id

    if @todo.destroy
      flash[:notice] = "Todo was removed."
    else
      flash[:error] = "Todo item couldn't be deleted. Try again."
    end

    respond_with(@todo) do |format|
      format.html { render :index}
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:description)
  end
end