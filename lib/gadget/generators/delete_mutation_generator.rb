module Gadget
  class DeleteMutationGenerator < Rails::Generators::NamedBase
    def modify_mutation
      inject_into_file "app/graphql/types/mutation_type.rb", "    field :delete_#{file_name}, mutation: Mutations::Delete#{name}Mutation\n", before: "  end\nend\n"
    end

    def create_mutation_file
      create_file "app/graphql/mutations/delete_#{file_name}_mutation.rb", <<EOS
module Mutations
  class Delete#{name}Mutation < BaseMutation
    delete_mutation_for #{name}
  end
end
EOS
    end
  end
end