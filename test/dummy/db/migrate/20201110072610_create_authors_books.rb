# frozen_string_literal: true

class CreateAuthorsBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :authors_books, comment: '著者・本関連' do |t|
      t.references :author, comment: 'author id'
      t.references :book, comment: 'book id'
    end
  end
end
