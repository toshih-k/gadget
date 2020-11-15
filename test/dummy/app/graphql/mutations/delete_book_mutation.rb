module Mutations
  class DeleteBookMutation < BaseMutation
    delete_mutation_for Book
  end
end
