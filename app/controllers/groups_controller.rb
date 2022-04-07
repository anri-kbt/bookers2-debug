class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @book=Book.new
    @groups=Group.all
  end

  def show
    @group=Group.find(params[:group_id])
  end

  def new
    @group = Group.new
  end

  def create
    @group=Group.new(params[:group_id])
    @group.owner_id = current_user.id
    if @group.save!
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
    @group=Group.find(params[:group_id])
    if @group.user=current_user
      render :edit
    end
  end

  def update
    @group=Group.find(params[:group_id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end

  private
  def group_params
    params.require(:group).permit(:name,:introduction,:image)
  end

end
