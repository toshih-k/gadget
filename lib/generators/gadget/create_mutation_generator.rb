module Gadget
  class CreateMutationGenerator < Rails::Generators::NamedBase
    def modify_mutation
      inject_into_file "app/graphql/types/mutation_type.rb", "    field :create_#{file_name}, mutation: Mutations::Create#{name}Mutation\n", before: "  end\nend\n"
    end

    def create_mutation_file
      create_file "app/graphql/mutations/create_#{file_name}_mutation.rb", <<EOS
module Mutations
  class Create#{name}Mutation < BaseMutation
    create_mutation_for #{name}
  end
end
EOS
    end
  end
end