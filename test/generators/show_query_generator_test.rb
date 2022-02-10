# frozen_string_literal: true

require 'test_helper'
require "generators/gadget/show_query_generator"

class ShowQueryGeneratorTest < Rails::Generators::TestCase
  tests Gadget::Generators::ShowQueryGenerator
  destination File.expand_path("../tmp", __dir__)
  setup :prepare_destination

  test "generate show query" do
    destdir = File.expand_path('../tmp/app/graphql/types', __dir__)
    FileUtils.mkdir_p(destdir)
    FileUtils.cp File.expand_path("../files/query_type.rb", __dir__), destdir
    run_generator ['Shop']
    assert_file '../tmp/app/graphql/types/query_type.rb', /field :shop, resolver: Queries::Shop/
    assert_file '../tmp/app/graphql/queries/shop.rb'
  end
end
