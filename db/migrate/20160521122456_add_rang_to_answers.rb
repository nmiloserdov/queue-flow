class AddRangToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :rang, :integer
  end
end
