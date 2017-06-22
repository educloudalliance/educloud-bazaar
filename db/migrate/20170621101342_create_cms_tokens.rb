class CreateCmsTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :cms_tokens do |t|
      t.string :token
      t.integer :material_id
      t.integer :cms_session_id
      t.integer :account_id
      t.datetime :expired_at, null: false
      t.boolean :used, default: false, null: false

      t.timestamps
    end
    add_index :cms_tokens, :token, unique: true
  end
end
