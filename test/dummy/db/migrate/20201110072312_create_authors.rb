class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.string :name, comment: "name"
      t.timestamps
    end
  end
end
