# frozen_string_literal: true

class DummySchema < GraphQL::Schema
  mutation Types::MutationType
  query Types::QueryType
end
