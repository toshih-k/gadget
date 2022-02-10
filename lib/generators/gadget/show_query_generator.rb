# frozen_string_literal: true

module Gadget
  module Generators
    #
    # generate show query
    #
    class ShowQueryGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)
      def check_model_existance
        raise "Cannot find model #{name}" unless Module.const_defined?(name)
      end

      def create_type
        generate 'gadget:type', name
      end

      def modify_query
        inject_into_file 'app/graphql/types/query_type.rb',
                         "    field :#{file_name}, resolver: Queries::#{name}\n",
                         before: "  end\nend\n"
      end

      def create_show_query_file
        template('queries/show.rb.tt', "app/graphql/queries/#{file_name}.rb", { name: name })
      end

    end
  end
end
