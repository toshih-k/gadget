require 'test_helper'

class MutationTest < ActionDispatch::IntegrationTest
  book_count = Book.count
  test "create mutation" do
    query = <<'GQL'
    mutation($input: CreateBookMutationInput!) {
      createBook(input: $input) {
        book {
          id
          name
          owner {
            id
            name
          }
        }
        clientMutationId
        errors
      }
    }
GQL
    variables = {
      input: {
        name: "foo",
        owner: {
          name: "bar"
        }
      }
    }
    post(
      '/graphql',
      {
        params: {
          query: query,
          variables: variables
        },
        as: :json
      }
    )
    assert_response 200
    res = JSON.parse(response.body)
    book = Book.find(res['data']['createBook']['book']['id'])
    assert_equal(Book.count, book_count + 1)
    assert_equal(book.name, res['data']['createBook']['book']['name'])
  end

  test "update mutation" do
    book = Book.first
    modified_book_name = book.name + "aaa"
    modified_owner_name = book.owner.name + "aaa"
    book_count = Book.count
    query = <<'GQL'
    mutation($input: UpdateBookMutationInput!) {
      updateBook(input: $input) {
        book {
          id
          name
          owner {
            id
            name
          }
        }
        clientMutationId
        errors
      }
    }
GQL
    variables = {
      input: {
        id: book.id,
        name: modified_book_name,
        owner: {
          id: book.owner.id,
          name: modified_owner_name
        }
      }
    }
    post(
      '/graphql',
      {
        params: {
          query: query,
          variables: variables
        },
        as: :json
      }
    )
    assert_response 200
    res = JSON.parse(response.body)
    book_modified = Book.find(book.id)
    assert_equal(book_count, Book.count)
    assert_equal(book_modified.name, modified_book_name)
    assert_equal(book_modified.owner.name, modified_owner_name)
  end

  test "delete mutation" do
    book = Book.first
    book_count = Book.count
    query = <<'GQL'
    mutation($input: DeleteBookMutationInput!) {
      deleteBook(input: $input) {
        book {
          id
          name
          owner
        }
        clientMutationId
        errors
      }
    }
GQL
    variables = {
      input: {
        id: book.id,
      }
    }
    post(
      '/graphql',
      {
        params: {
          query: query,
          variables: variables
        },
        as: :json
      }
    )
    assert_response 200
    res = JSON.parse(response.body)
    book_modified = Book.find(book.id)
    assert_equal(book_count, Book.count)
  end

end
