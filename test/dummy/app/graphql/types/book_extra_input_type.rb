# frozen_string_literal: true

module Types
  class BookExtraInputType < BaseInputObject
    include Gadget::Types::InputObject
    from_active_record ::BookExtra
  end
end
