module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    include Gadget::Mutation::Create
    include Gadget::Mutation::Update
    include Gadget::Mutation::Delete

    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject
  end
end
