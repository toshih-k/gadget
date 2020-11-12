module Types
  class BaseInputObject < GraphQL::Schema::InputObject
    include Gadget::Types::InputObject
    argument_class Types::BaseArgument
  end
end
