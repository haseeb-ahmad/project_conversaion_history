class CreateComments < ActiveRecord::Migration[8.0]
  def up
    create_table :comments do |t|
      t.string :title, :limit => 50, :default => "" 
      t.text :comment
      t.references :commentable, :polymorphic => true
      t.references :user
      t.string :role, :default => "comments"
      t.timestamps
    end

    add_index :comments, :commentable_type
    add_index :comments, :commentable_id
  end

  def down
    drop_table :comments
  end
end
