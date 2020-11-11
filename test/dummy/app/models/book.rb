class Book < ApplicationRecord
  belongs_to :owner
  has_and_belongs_to_many :authors
end
