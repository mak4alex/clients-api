class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.boolean :sex
      t.string :id_number
      t.string :phone
      t.text :address

      t.timestamps null: false
    end
  end
end
