class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.string :content
      t.string :user_name
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end