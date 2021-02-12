# frozen_string_literal: true

module Types
  class BookPaginatedType < Types::BaseObject
    field :records, [Types::BookType], null: false
    field :total_count, GraphQL::Types::Int, null: false
    field :current_page, GraphQL::Types::Int, null: false
    field :per_page, GraphQL::Types::Int, null: false
  end
end
