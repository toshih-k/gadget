# frozen_string_literal: true

module Gadget
  module Generators
    #
    # generate input type
    #
    class EnumTypeGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      class_option :attribute, type: :string, banner: '[enum attribute name]', desc: 'Enum attribute name'
      def check_model_existance
        raise "Cannot find model #{name}" unless Module.const_defined?(name)
      end

      def create_type_file
        template('types/enum_type.rb.tt', "app/graphql/types/#{file_name}_#{attribute}_type.rb", { name: name, attribute: attribute })
      end
    end
  end
end
