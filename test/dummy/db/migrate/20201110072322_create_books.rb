# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books, comment: '本' do |t|
      t.string :name, comment: 'name'
      t.references :owner, comment: 'owner id'
      t.integer :inventory_type, limit: 1, comment: 'inventory type:1:has stock,2:no stock,3:ebook'
      t.timestamps
    end
  end
end
