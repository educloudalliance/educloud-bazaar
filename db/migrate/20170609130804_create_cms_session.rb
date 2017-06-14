class CreateCmsSession < ActiveRecord::Migration[5.0]
  def change
    create_table :cms_sessions do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email
      t.string :user_id, null: false
      t.string :context_id, null: false
      t.integer :role, null: false
      t.string :school, null: false
      t.string :school_id, null: false
      t.string :city, null: false
      t.string :city_id, null: false
      t.string :oid
      t.string :add_resource_callback_url
      t.string :cancel_url
      t.string :uid, null: false
    end
    add_index :cms_sessions, :uid, unique: true
  end
end
