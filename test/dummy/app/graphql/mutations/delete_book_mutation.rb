# frozen_string_literal: true

module Mutations
  class DeleteBookMutation < BaseMutation
    include Gadget::Mutation::Delete
    delete_mutation_for ::Book
  end
end
