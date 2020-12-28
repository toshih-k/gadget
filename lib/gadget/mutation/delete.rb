module Gadget
  module Mutation
    module Delete
      extend ActiveSupport::Concern
      included do
        class << self
          def delete_mutation_for(active_record_class, options)
            description "delete #{active_record_class.name}"
            argument active_record_class.primary_key, GraphQL::Types::ID, required: true

            define_method("resolve") do |params|
              params = params.as_json
              instance = active_record_class.find(params[active_record_class.primary_key])
              if instance.destroy
                {
                  Gadget::Common::Utility.result_field_name(active_record_class) => instance
                }
              else
                {
                  Gadget::Common::Utility.result_field_name(active_record_class) => instance,
                  "errors" => instance.errors.full_messages
                }
              end
            end
          end
        end
      end
    end
  end
end


