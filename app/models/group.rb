class Group < ApplicationRecord
    has_many :group_users, dependent: :destroy
    
    attachment :image
    
    def is_member?(user)
        group_user = GroupUser.find_by(user_id: user.id, group_id: self.id)
        self.group_users.include?(group_user)
    end
end
