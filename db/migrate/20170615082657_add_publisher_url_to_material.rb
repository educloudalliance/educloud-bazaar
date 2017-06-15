class AddPublisherUrlToMaterial < ActiveRecord::Migration[5.0]
  def change
    add_column :materials, :publisher_url, :string
  end
end
