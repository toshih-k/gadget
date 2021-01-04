class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors, "著者" do |t|
      t.string :name, comment: "name"
      t.timestamps
    end
  end
end
