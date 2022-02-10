# frozen_string_literal: true

module Types
  class SectionType < Types::BaseObject
    include Gadget::Types::Object
    from_active_record ::Section
  end
end
