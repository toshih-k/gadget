# frozen_string_literal: true

module Gadget
  module Generators
    #
    # generate create mutation
    #
    class CreateMutationGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)
      def check_model_existance
        raise "Cannot find model #{name}" unless Module.const_defined?(name)
      end

      def modify_mutation
        inject_into_file 'app/graphql/types/mutation_type.rb',
                        "    field :create_#{file_name}, mutation: Mutations::Create#{name}Mutation\n",
                        before: "  end\nend\n"
      end

      def create_mutation_file
        template('mutations/create.rb.tt', "app/graphql/mutations/create_#{file_name}_mutation.rb", { name: name })
      end
    end
  end
end
