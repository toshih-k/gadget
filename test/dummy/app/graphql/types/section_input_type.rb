# frozen_string_literal: true

module Types
  class SectionInputType < Types::BaseInputObject
    from_active_record Section
  end
end
