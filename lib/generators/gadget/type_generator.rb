# frozen_string_literal: true

module Gadget
  class TypeGenerator < Rails::Generators::NamedBase
    def check_model_existance
      raise "Cannot find model #{name}" unless Module.const_defined?(name)
    end

    def create_type_file
      create_file "app/graphql/types/#{file_name}_type.rb", <<~EOS
        module Types
          class #{name}Type < Types::BaseObject
            from_active_record #{name}
          end
        end
      EOS
    end
  end
end
