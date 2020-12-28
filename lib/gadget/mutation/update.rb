module Gadget
  module Mutation
    module Update
      extend ActiveSupport::Concern
      included do
        class << self
          def update_mutation_for(active_record_class, options = {})
            description "update #{active_record_class.name}"
            field Gadget::Common::Utility.result_field_name(active_record_class), Gadget::Common::Utility.object_type_class(active_record_class), null: false
            field "errors", GraphQL::Types::JSON, null: true
            Gadget::Common::Utility.generate_input_arguments(self, active_record_class, options) do
              yield if block_given?
            end

            define_method("resolve") do |params|
              params = params.as_json
              instance = active_record_class.find(params["id"])
              attributes = params.keys.reduce({}) do |attributes, key|
                if active_record_class.reflections.keys.include?(key.to_s)
                  values = params[key]
                  attributes["#{key}_attributes"] = values if values
                else
                  attributes[key] = params[key]
                end
                attributes
              end
              instance.attributes = attributes
              if instance.save
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


