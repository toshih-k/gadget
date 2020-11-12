class CreateBookExtras < ActiveRecord::Migration[6.0]
  def change
    create_table :book_extras do |t|
      t.references :book, comment: 'book id'
      t.string :editors_comment, comment: 'editors comment'
      t.string :sales_comment, comment: 'sales comment'
      t.timestamps
    end
  end
end
