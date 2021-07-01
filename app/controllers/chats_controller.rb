class ChatsController < ApplicationController
    before_action :follow_each_other
    
    def show
        @user = User.find(params[:id])
        @chats = Chat.where(my_id: current_user.id, your_id: @user.id).or(Chat.where(my_id: @user.id, your_id: current_user.id))
        @chat = Chat.new
    end
    
    def create
        @chat = Chat.new(chat_params)
        @chat.my_id = current_user.id
        @chat.your_id = params[:id]
        if @chat.save
            redirect_to chat_path(params[:id])
        else
            @user = User.find(params[:id])
            @chats = Chat.where(my_id: current_user.id, your_id: @user.id).or(Chat.where(my_id: @user.id, your_id: current_user.id))
            render :show
        end
    end
    
    private
    
    def chat_params
        params.require(:chat).permit(:text)
    end
    
    def follow_each_other
        @user = User.find(params[:id])
        unless @user.following?(current_user) && current_user.following?(@user)
            redirect_to user_path(@user)
        end
    end
end
