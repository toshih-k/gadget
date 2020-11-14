module Gadget
  module Mutation
    module Delete
      extend ActiveSupport::Concern
      included do
        class << self
          def delete_mutation_for(active_record_class)
            description "delete #{active_record_class.name}"
            argument active_record_class.primary_key, GraphQL::Types::ID, required: true
          end
        end
      end
    end
  end
end


