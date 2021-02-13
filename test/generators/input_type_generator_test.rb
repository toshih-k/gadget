# frozen_string_literal: true

require 'test_helper'
require "generators/gadget/input_type_generator"

class InputTypeGeneratorTest < Rails::Generators::TestCase
  tests Gadget::Generators::InputTypeGenerator
  destination File.expand_path("../tmp", __dir__)
  setup :prepare_destination

  test "generate input type" do
    run_generator ['Shop']
    assert_file '../tmp/app/graphql/types/shop_input_type.rb'
  end
end
