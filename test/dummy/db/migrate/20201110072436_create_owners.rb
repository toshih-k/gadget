# frozen_string_literal: true

class CreateOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :owners, comment: '所有者' do |t|
      t.string :name, comment: 'name'
      t.timestamps
    end
  end
end
