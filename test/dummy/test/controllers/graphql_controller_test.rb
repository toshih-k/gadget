require 'test_helper'

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  test "必須パラメーター不足 400 返却" do
    # headers: x-user-token がない
    post '/graphql', params: { title: 'title', body: 'body-1', email: 'email-1'}, as: :json
    assert_response 400
    res = JSON.parse(response.body)
    assert_equal('ng', res['result'])
    assert_equal('ng-001', res['code'])
  end
end