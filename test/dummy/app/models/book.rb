# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :owner
  has_one :book_extra
  has_many :sections
  has_and_belongs_to_many :authors
  accepts_nested_attributes_for :owner

  enum inventory_type: {
    has_stock: 1,
    no_stock: 2,
    ebook: 3
  }

  attribute :title, :integer
end
