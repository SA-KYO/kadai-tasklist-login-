class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :destroy]
  before_action :require_user_logged_in, only: [:index]

  def index
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page]).per(10)
  end

  def create
    # ログインユーザのIDでタスクを作成する
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが正常に登録されませんでした'
      render :new
    end
  end

  def new
    @task = Task.new
  end

  def edit
    set_task
  end

  def show
    set_task
  end

  def update
    set_task
    
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが正常に更新されませんでした'
      render :edit
    end
  end

  def destroy
    set_task
    @task.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content,:status)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end