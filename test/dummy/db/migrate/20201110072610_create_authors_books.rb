class CreateAuthorsBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :authors_books do |t|
      t.references :auther, comment: "author id"
      t.references :book, comment: "book id"
      t.timestamps
    end
  end
end
