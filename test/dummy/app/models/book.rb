class Book < ApplicationRecord
  belongs_to :owner
  has_one :book_extra
  has_many :sections
  has_and_belongs_to_many :authors
end
