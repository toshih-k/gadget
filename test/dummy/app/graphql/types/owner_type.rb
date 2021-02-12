# frozen_string_literal: true

module Types
  class OwnerType < Types::BaseObject
    from_active_record Owner
  end
end
