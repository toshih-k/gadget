# frozen_string_literal: true

module Gadget
  #
  # initialize gadget in rails application
  #
  class Railtie < ::Rails::Railtie
    initializer 'gadget' do |_app|
      require 'gadget/common/utility'
      require 'gadget/types/enum'
      require 'gadget/types/object'
      require 'gadget/types/input_object'
      require 'gadget/query/index'
      require 'gadget/query/show'
      require 'gadget/mutation/create'
      require 'gadget/mutation/update'
      require 'gadget/mutation/delete'

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
