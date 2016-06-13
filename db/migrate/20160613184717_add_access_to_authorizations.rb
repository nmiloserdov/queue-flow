class AddAccessToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :access, :boolean, default: true
    Authorization.all.each do |auth|
      auth.update_attribute(:access, true)
    end
  end
end
