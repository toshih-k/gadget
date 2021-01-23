class Owner < ApplicationRecord
  has_many :books

  def self.gadget_authorization(context, type)
    case type
    when :show_query
      true
    else
      false
    end
  end
end
