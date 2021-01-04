module Gadget
  module Mutation
    module Create
      extend ActiveSupport::Concern
      included do
        class << self
          def create_mutation_for(active_record_class, options = {})
            description "#{active_record_class.model_name.human}を作成する"
            field Gadget::Common::Utility.result_field_name(active_record_class), Gadget::Common::Utility.object_type_class(active_record_class), null: false
            field "errors", GraphQL::Types::JSON, null: true
            Gadget::Common::Utility.generate_input_arguments(self, active_record_class, options) do
              yield if block_given?
            end

            define_method("resolve") do |params|
              params = params.as_json
              attributes = params.keys.reduce({}) do |attributes, key|
                if active_record_class.reflections.keys.include?(key.to_s)
                  values = params[key]
                  attributes["#{key}_attributes"] = values if values
                else
                  attributes[key] = params[key]
                end
                attributes
              end
              instance = active_record_class.new(attributes)
              instance.save
              if instance.save
                {
                  Gadget::Common::Utility.result_field_name(active_record_class).to_sym => instance.as_json,
                  "clientMutationId" => instance.id,
                  "errors" => []
                }
              else
                {
                  Gadget::Common::Utility.result_field_name(active_record_class).to_sym => instance,
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
