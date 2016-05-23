class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true, index: true
      t.integer    :vote_type
      t.references :user

      t.timestamps null: false
    end
  end
end
