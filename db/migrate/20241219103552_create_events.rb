class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :total_tickets
      t.integer :remaining_tickets

      t.timestamps
    end
  end
end
