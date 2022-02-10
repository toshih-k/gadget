# frozen_string_literal: true

module Mutations
  class UpdateBookMutation < BaseMutation
    include Gadget::Mutation::Update
    update_mutation_for ::Book
  end
end
