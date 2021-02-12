# frozen_string_literal: true

class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors, comment: '著者' do |t|
      t.string :name, comment: 'name'
      t.timestamps
    end
  end
end
