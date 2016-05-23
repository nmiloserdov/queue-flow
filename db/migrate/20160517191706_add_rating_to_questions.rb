class AddRatingToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :rang, :integer, default: 0
  end
end
