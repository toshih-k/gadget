# frozen_string_literal: true

module Gadget
  module Generators
    #
    # generate show query
    #
    class ShowQueryGenerator < Rails::Generators::NamedBase
      def check_model_existance
        raise "Cannot find model #{name}" unless Module.const_defined?(name)
      end

      def create_type
        generate 'gadget:type', name
      end

      def modify_query
        inject_into_file 'app/graphql/types/query_type.rb', "    show #{name}\n", before: "  end\nend\n"
      end
    end
  end
end
