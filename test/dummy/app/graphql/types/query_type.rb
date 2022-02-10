# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
                               description: 'An example field added by the generator'
    def test_field
      'Hello World!'
    end

    # index Book
    # show Book
    # index Book, name: 'BooksRenamed'
    # show Book, name: 'BookRenamed'
    # index Owner
    # show Owner
    field :books, resolver: Queries::Books
    field :book, resolver: Queries::Book
    field :books_renamed, resolver: Queries::BooksRenamed
    field :book_renamed, resolver: Queries::BookRenamed
    field :owners, resolver: Queries::Owners
    field :owner, resolver: Queries::Owner


  end
end
