# frozen_string_literal: true

module Mutations
  class CreateBookMutation < BaseMutation
    create_mutation_for Book
  end
end
