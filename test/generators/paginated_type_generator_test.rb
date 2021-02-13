# frozen_string_literal: true

require 'test_helper'
require "generators/gadget/paginated_type_generator"

class PaginatedTypeGeneratorTest < Rails::Generators::TestCase
  tests Gadget::Generators::PaginatedTypeGenerator
  destination File.expand_path("../tmp", __dir__)
  setup :prepare_destination

  test "generate paginated type" do
    run_generator ['Shop']
    assert_file '../tmp/app/graphql/types/shop_paginated_type.rb'
  end
end
