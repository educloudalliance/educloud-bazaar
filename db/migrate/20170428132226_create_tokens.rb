class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.string :client_id, unique: true, index: true
      t.string :secret_key, unique: true, index: true

      t.timestamps
    end
  end
end
