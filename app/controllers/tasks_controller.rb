class TasksController < ApplicationController

  before_action :find_task_list

  def new
    @task = Task.new
  end

  def create
    @task = @task_list.tasks.new(params.require(:task).permit(:description, :due_date))
    if @task.save
      redirect_to root_path, notice: "Task was created successfully!"
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
    @task_list = TaskList.find(params[:task_list_id])
  end

  def update
    if params[:commit] == 'Complete'
      @task = @task_list.tasks.find(params[:id])
      @task.update_attributes(completed: true)
      redirect_to root_path, notice: "Task was completed successfully!"
    else
      task = Task.find(params[:id])
      task.update_attributes(params.require(:task).permit(:description, :due_date))
      redirect_to root_path, notice: "Task was updated successfully!"
    end

  end

  private

  def find_task_list
    @task_list = TaskList.find(params[:task_list_id])
  end

end