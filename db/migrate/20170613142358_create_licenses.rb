class CreateLicenses < ActiveRecord::Migration[5.0]
  def change
    create_table :licenses do |t|
      t.references :product, null: false
      t.string :school_id
      t.string :city_id
      t.date :expire_on

      t.timestamps
    end
  end
end
