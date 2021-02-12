# frozen_string_literal: true

module Gadget
  class UpdateMutationGenerator < Rails::Generators::NamedBase
    def check_model_existance
      raise "Cannot find model #{name}" unless Module.const_defined?(name)
    end

    def modify_mutation
      inject_into_file 'app/graphql/types/mutation_type.rb',
                       "    field :update_#{file_name}, mutation: Mutations::Update#{name}Mutation\n", before: "  end\nend\n"
    end

    def create_mutation_file
      create_file "app/graphql/mutations/update_#{file_name}_mutation.rb", <<~EOS
        module Mutations
          class Update#{name}Mutation < BaseMutation
            update_mutation_for #{name}
          end
        end
      EOS
    end
  end
end
