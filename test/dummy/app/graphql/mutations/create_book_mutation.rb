module Mutations
  class CreateBookMutation < BaseMutation
    include Gadget::Mutation::Create
    create_mutation_for ::Book
  end
end
