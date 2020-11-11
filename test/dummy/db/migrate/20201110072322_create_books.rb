class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :name, comment: "name"
      t.references :onwer, comment: "owner id"
      t.timestamps
    end
  end
end
