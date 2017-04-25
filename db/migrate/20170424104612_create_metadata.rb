class CreateMetadata < ActiveRecord::Migration[5.0]
  def change
    create_table :metadata do |t|
      t.string :country
      t.string :subject
      t.timestamps
    end
  end
end
