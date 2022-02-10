# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
                               description: 'An example field added by the generator'
    def test_field
      'Hello World'
    end

    field :create_owner, mutation: Mutations::CreateOwnerMutation
    field :update_owner, mutation: Mutations::UpdateOwnerMutation
    field :delete_owner, mutation: Mutations::DeleteOwnerMutation
  end
end
