require 'test_helper'

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  test "simple index query" do
    books = Book.all

    post '/graphql', params: { query: '{ books {name} }' }, as: :json
    assert_response 200
    res = JSON.parse(response.body)
    assert_equal(books.count, res['data']['books'].count)
    assert_equal(books[0].name, res['data']['books'][0]['name'])
  end

  test "index query with any relation(belongs_to, has_one, has_many, has_and_belongs_to_many" do
    books = Book.all

    post '/graphql', params: { query: 'query { books {name owner{name} bookExtra{editorsComment} sections{name} authors{name}} }' }, as: :json
    assert_response 200
    res = JSON.parse(response.body)
    assert_equal(books.count, res['data']['books'].count)
    assert_equal(books[0].name, res['data']['books'][0]['name'])
    assert_equal(books[0].owner.name, res['data']['books'][0]['owner']['name'])
    assert_equal(books[0].book_extra.editors_comment, res['data']['books'][0]['bookExtra']['editorsComment'])
    assert_equal(books[0].sections.count, res['data']['books'][0]['sections'].count)
    assert_equal(books[0].sections[0].name, res['data']['books'][0]['sections'][0]['name'])
  end

  test "show query with any relation(belongs_to, has_one, has_many, has_and_belongs_to_many" do
    book = Book.first

    post '/graphql', params: { query: 'query($id: ID!) { book(id: $id) {name owner{name} bookExtra{editorsComment} sections{name} authors{name}} }', variables: {id: book.id} }, as: :json
    assert_response 200
    res = JSON.parse(response.body)
    assert_equal(book.name, res['data']['book']['name'])
    assert_equal(book.owner.name, res['data']['book']['owner']['name'])
    assert_equal(book.book_extra.editors_comment, res['data']['book']['bookExtra']['editorsComment'])
    assert_equal(book.sections.count, res['data']['book']['sections'].count)
    assert_equal(book.sections[0].name, res['data']['book']['sections'][0]['name'])
  end
end