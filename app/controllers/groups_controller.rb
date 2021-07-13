class GroupsController < ApplicationController
    before_action :authenticate_user!
    before_action :is_owner, only: [:edit, :update]
    
    def index
        @groups = Group.all
        @user = current_user
        @book = Book.new
    end
    
    def new
        @group = Group.new
    end
    
    def show
        @group = Group.find(params[:id])
        @user = current_user
    end
    
    def create
        @group = Group.new(group_params)
        @group.owner_id = current_user.id
        if @group.save
            group_user = GroupUser.create(user_id: current_user.id, group_id: @group.id)
            redirect_to groups_path
        else
            render :new
        end
    end

    def update
        @group = Group.find(params[:id])
        if @group.update(group_params)
            redirect_to groups_path
        else
            render :edit
        end
    end
    
    def edit
        @group = Group.find(params[:id])
    end
    
    def join
        group = Group.find(params[:id])
        group_user = GroupUser.new
        group_user.user_id = current_user.id
        group_user.group_id = group.id
        if group_user.save
            redirect_to group_path(group)
        end
    end

    def leave
        group = Group.find(params[:id])
        group_user = GroupUser.find_by(user_id: current_user.id, group_id: group.id)
        if group_user.destroy
            redirect_to group_path
        end
    end
    
    private
    def group_params
        params.require(:group).permit(:name, :introduction, :image)
    end
    
    def is_owner
        group = Group.find(params[:id])
        if group.owner_id != current_user.id
            redirect_to groups_path
        end
    end
    
end
