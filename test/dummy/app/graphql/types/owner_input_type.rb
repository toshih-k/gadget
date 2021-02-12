# frozen_string_literal: true

module Types
  class OwnerInputType < Types::BaseInputObject
    from_active_record Owner
  end
end
