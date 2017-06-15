class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.integer :kind, default: 0, limit: 1, null: false

      t.timestamps
    end
  end
end
