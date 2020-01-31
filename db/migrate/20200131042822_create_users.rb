class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :email
      t.string :full_name
      t.string :phone_no
      t.string :location
      t.string :password_digest
      t.text :website
      t.text :about

      t.timestamps
    end
  end
end
