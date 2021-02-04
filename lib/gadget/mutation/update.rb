module Gadget
  module Mutation
    module Update
      extend ActiveSupport::Concern
      included do
        class << self
          def update_mutation_for(active_record_class, options = {})
            description "#{active_record_class.model_name.human}を更新する"
            field "success", GraphQL::Types::Boolean, null: false
            field Gadget::Common::Utility.result_field_name(active_record_class), Gadget::Common::Utility.object_type_class(active_record_class), null: false
            field "errors", GraphQL::Types::JSON, null: true
            Gadget::Common::Utility.generate_input_arguments(self, active_record_class, options) do
              yield if block_given?
            end

            define_method("resolve") do |params|
              unless Gadget::Common::Utility.execute_method_if_exist(active_record_class, true, :gadget_authorization, context, :update_mutation)
                raise 'access denied'
              end
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
                  success: true,
                  Gadget::Common::Utility.result_field_name(active_record_class) => instance.as_json
                }
              else
                {
                  success: false,
                  Gadget::Common::Utility.result_field_name(active_record_class) => instance.as_json,
                  "errors" => Gadget::Common::Utility.make_error_messages(instance.errors)
                }
              end
            end
          end
        end
      end
    end
  end
end


