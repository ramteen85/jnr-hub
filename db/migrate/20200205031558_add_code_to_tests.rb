class AddCodeToTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :code, :text
  end
end
