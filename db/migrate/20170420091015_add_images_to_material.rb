class AddImagesToMaterial < ActiveRecord::Migration[5.0]
  def change
    add_attachment :materials, :image
  end
end
