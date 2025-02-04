class Comment < ApplicationRecord
  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  belongs_to :user

  validates :comment, presence: true

  belongs_to :parent, class_name: "Comment", optional: true
  has_many :children, class_name: "Comment", foreign_key: "parent_id"
end
