class RemoveImageModel < ActiveRecord::Migration[5.0]
  def up
    drop_table :images
  end

  def down
    create_table :images do |t|
      t.string :url
      t.integer :kind
      t.integer :width
      t.integer :height
      t.belongs_to :material, index: true
      t.timestamps
    end
  end
end
