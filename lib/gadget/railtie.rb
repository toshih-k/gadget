module Gadget
  class Railtie < ::Rails::Railtie
    initializer 'gadget' do |app|
      require 'gadget/common/utility'
      require 'gadget/types/enum'
      require 'gadget/types/object'
      require 'gadget/types/input_object'
      require 'gadget/query/index'
      require 'gadget/query/show'
      require 'gadget/mutation/create'
      require 'gadget/mutation/update'
      require 'gadget/mutation/delete'
      require 'gadget/generators/type_generator'
      require 'gadget/generators/input_type_generator'
      require 'gadget/generators/index_query_generator'
      require 'gadget/generators/show_query_generator'
      require 'gadget/generators/create_mutation_generator'
      require 'gadget/generators/update_mutation_generator'
      require 'gadget/generators/delete_mutation_generator'

      GraphQL::Schema::Object.include Gadget::Types::Object
      GraphQL::Schema::InputObject.include Gadget::Types::InputObject
      GraphQL::Schema::Enum.include Gadget::Types::Enum

      GraphQL::Schema::Object.include Gadget::Query::Index
      GraphQL::Schema::Object.include Gadget::Query::Show

      GraphQL::Schema::Object.include Gadget::Query::Index
      GraphQL::Schema::Object.include Gadget::Query::Show

      GraphQL::Schema::RelayClassicMutation.include Gadget::Mutation::Create
      GraphQL::Schema::RelayClassicMutation.include Gadget::Mutation::Update
      GraphQL::Schema::RelayClassicMutation.include Gadget::Mutation::Delete
    end
  end
end
