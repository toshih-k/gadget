# frozen_string_literal: true

module Types
  class BookExtraType < Types::BaseObject
    include Gadget::Types::Object
    from_active_record ::BookExtra
  end
end
