# frozen_string_literal: true

require 'test_helper'
require "generators/gadget/index_query_generator"

class IndexQueryGeneratorTest < Rails::Generators::TestCase
  tests Gadget::Generators::IndexQueryGenerator
  destination File.expand_path("../tmp", __dir__)
  setup :prepare_destination

  test "generate index query" do
    destdir = File.expand_path('../tmp/app/graphql/types', __dir__)
    FileUtils.mkdir_p(destdir)
    FileUtils.cp File.expand_path("../files/query_type.rb", __dir__), destdir
    run_generator ['Shop']
    assert_file '../tmp/app/graphql/types/query_type.rb', /field :shops, resolver: Queries::Shops/
    assert_file '../tmp/app/graphql/queries/shops.rb'
  end
end
