module Types
  class BaseEnum < GraphQL::Schema::Enum
    include Gadget::Types::Enum
  end
end
