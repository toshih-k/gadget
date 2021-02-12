# frozen_string_literal: true

module Gadget
  class PaginatedTypeGenerator < Rails::Generators::NamedBase
    def check_model_existance
      raise "Cannot find model #{name}" unless Module.const_defined?(name)
    end

    def create_type_file
      create_file "app/graphql/types/#{file_name}_paginated_type.rb", <<~EOS
        module Types
          class #{name}PaginatedType < Types::BaseObject
            field :records, [Types::#{name}Type], null: false
            field :total_count, GraphQL::Types::Int, null: false
            field :current_page, GraphQL::Types::Int, null: false
            field :per_page, GraphQL::Types::Int, null: false
          end
        end
      EOS
    end
  end
end
