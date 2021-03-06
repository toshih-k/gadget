module Types
  class ShopPaginatedType < Types::BaseObject
    field :records, [Types::ShopType], null: false
    field :total_count, GraphQL::Types::Int, null: false
    field :current_page, GraphQL::Types::Int, null: false
    field :per_page, GraphQL::Types::Int, null: false
  end
end
