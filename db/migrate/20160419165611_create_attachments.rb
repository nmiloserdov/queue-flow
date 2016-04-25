class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer    :attachmentable_id, index: true
      t.string     :attachmentable_type, index: true
      t.string     :file

      t.timestamps null: false
    end
  end
end
