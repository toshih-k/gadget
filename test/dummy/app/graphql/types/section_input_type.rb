# frozen_string_literal: true

module Types
  class SectionInputType < Types::BaseInputObject
    include Gadget::Types::InputObject
    from_active_record ::Section
  end
end
