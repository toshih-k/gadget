# frozen_string_literal: true

module Gadget
  module Generators
    #
    # generate input type
    #
    class InputTypeGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)
      def check_model_existance
        raise "Cannot find model #{name}" unless Module.const_defined?(name)
      end

      def create_type_file
        template('types/input_type.rb.tt', "app/graphql/types/#{file_name}_input_type.rb", { name: name })
      end
    end
  end
end
