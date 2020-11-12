module Types
  class BaseObject < GraphQL::Schema::Object
    include Gadget::Types::Object
    include Gadget::Query::Index
    # include Gadget::Query::PaginatedIndex
    include Gadget::Query::Show
    field_class Types::BaseField
  end
end
