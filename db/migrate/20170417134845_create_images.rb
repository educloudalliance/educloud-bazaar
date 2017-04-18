class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :url
      t.string :type
      t.integer :width
      t.integer :height
      t.belongs_to :material, index: true
      t.timestamps
    end
  end
end
