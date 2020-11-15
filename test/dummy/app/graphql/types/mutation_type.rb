module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
                               description: "An example field added by the generator"
    def test_field
      "Hello World"
    end

    field :create_book, mutation: Mutations::CreateBookMutation
    field :update_book, mutation: Mutations::UpdateBookMutation
    field :delete_book, mutation: Mutations::DeleteBookMutation
  end
end
