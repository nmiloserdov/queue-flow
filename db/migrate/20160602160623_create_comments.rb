class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.references :user
      t.integer :commentable_id
      t.string :commentable_type
      t.timestamps null: false
    end
  end
end
