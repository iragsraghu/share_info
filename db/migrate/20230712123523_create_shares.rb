class CreateShares < ActiveRecord::Migration[7.0]
  def change
    create_table :shares do |t|
      t.string :name
      t.string :symbol
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
