# frozen_string_literal: true

class Owner < ApplicationRecord
  has_many :books

  def self.gadget_authorization(_context, type)
    case type
    when :show_query
      true
    else
      false
    end
  end
end
