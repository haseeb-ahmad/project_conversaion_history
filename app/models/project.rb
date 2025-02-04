class Project < ApplicationRecord
    acts_as_commentable
    enum :status, %w[pending in_progress completed on_hold]
  
    validates :status, presence: true
  
    has_and_belongs_to_many :users
end