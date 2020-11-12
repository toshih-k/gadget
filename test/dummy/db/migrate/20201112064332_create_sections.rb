class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.string :name, comment: 'name'
      t.references :book, comment: 'book id'
      t.timestamps
    end
  end
end
