class EmailsController < ApplicationController
  before_action :is_owner, only: [:edit, :update]

  def new
    @email = Email.new
  end

  def show
    @email = Email.find(params[:id])
  end
  
  def create
    email = Email.new(email_params)
    if email.save
        redirect_to email_path(email)
    end
  end
  
  private
  def email_params
    params.require(:email).permit(:title, :body)
  end
    
  def is_owner
    group = Group.find(params[:group_id])
    if group.owner_id != current_user.id
        redirect_to groups_path
    end
  end
end
