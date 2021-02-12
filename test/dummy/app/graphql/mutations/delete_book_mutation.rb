# frozen_string_literal: true

module Mutations
  class DeleteBookMutation < BaseMutation
    delete_mutation_for Book
  end
end
