class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :callback_url
      t.string :api_key

      t.timestamps
    end
  end
end
