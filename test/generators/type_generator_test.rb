# frozen_string_literal: true

require 'test_helper'
require "generators/gadget/type_generator"

class TypeGeneratorTest < Rails::Generators::TestCase
  tests Gadget::Generators::TypeGenerator
  destination File.expand_path("../tmp", __dir__)
  setup :prepare_destination

  test "generate type" do
    run_generator ['Shop']
    assert_file '../tmp/app/graphql/types/shop_type.rb'
  end
end
