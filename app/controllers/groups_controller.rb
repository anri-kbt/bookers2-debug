class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @book=Book.new
    @groups=Group.all
    @group = Group.new
  end

  def show
    @group=Group.find(params[:id])
    @user=current_user
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def join
    @group = Group.find(params[:group_id])
    if !@group.users.include?(current_user)
      @group.users << current_user
      redirect_to groups_path
    end
  end

  def edit
    @group = Group.find(params[:id])
    if @group.owner_id=current_user.id
      render :edit
    end
  end

  def update
    @group=Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end
  
  def new_mail
    @group = Group.find(params[:group_id])
  end
  
  def send_mail
    @group = Group.find(params[:group_id])
    group_users = @group.users
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    ContactMailer.send_mail(@gmail_title, @mail_content,group_users).deliver
  

  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user) #current_userは@group.usersから消される
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

end
