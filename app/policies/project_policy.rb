class ProjectPolicy < ApplicationPolicy
    def change_status?
      user.manager? || user.employee?
    end
  
    def comment?
      record.users.include?(user)
    end
  end
  