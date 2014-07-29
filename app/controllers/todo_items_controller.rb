class TodoItemsController < ApplicationController
  def index
    @todolist = Todolist.find(params[:todolist_id])
  end

  def new
    @todolist = Todolist.find(params[:todolist_id])
    @todo_item = @todolist.todo_items.new
  end

  def create
    @todolist = Todolist.find(params[:todolist_id])
    @todo_item = @todolist.todo_items.new(todo_item_params)
    if @todo_item.save
      flash[:success] = 'Added todo item'
      redirect_to todolist_todo_items_path
    else
      flash[:error] = 'There was a problem/error adding that todo item'
      render action: :new
    end
  end

  def edit
    @todolist = Todolist.find(params[:todolist_id])
    @todo_item = @todolist.todo_items.find(params[:id])
  end

  def update
    @todolist = Todolist.find(params[:todolist_id])
    @todo_item = @todolist.todo_items.find(params[:id])
    if @todo_item.update_attributes(todo_item_params)
      flash[:success] = 'Saved todo item'
      redirect_to todolist_todo_items_path
    else
      flash[:error] = 'There was a problem/error adding that todo item'
      render action: :edit
    end
  end

  def url_options
    {todolist_id: params[:todolist_id]}.merge(super)
  end

  private
  def todo_item_params
    params[:todo_item].permit(:content)
  end
end
