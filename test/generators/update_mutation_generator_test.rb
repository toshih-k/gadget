# frozen_string_literal: true

require 'test_helper'
require "generators/gadget/update_mutation_generator"

class UpdateMutationGeneratorTest < Rails::Generators::TestCase
  tests Gadget::Generators::UpdateMutationGenerator
  destination File.expand_path("../tmp", __dir__)
  setup :prepare_destination

  test "generate update mutation" do
    destdir = File.expand_path('../tmp/app/graphql/types', __dir__)
    FileUtils.mkdir_p(destdir)
    FileUtils.cp File.expand_path("../files/mutation_type.rb", __dir__), destdir

    run_generator ['Shop']
    assert_file '../tmp/app/graphql/types/mutation_type.rb'
      /field :update_shop, mutation: Mutations::UpdateShopMutation/
    assert_file '../tmp/app/graphql/mutations/update_shop_mutation.rb'
  end
end
