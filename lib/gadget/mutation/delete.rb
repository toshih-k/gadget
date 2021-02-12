# frozen_string_literal: true

module Gadget
  module Mutation
    module Delete
      extend ActiveSupport::Concern
      included do
        class << self
          def delete_mutation_for(active_record_class, _options = {})
            description "#{active_record_class.model_name.human}を削除する"
            field 'success', GraphQL::Types::Boolean, null: false
            field Gadget::Common::Utility.result_field_name(active_record_class),
                  Gadget::Common::Utility.object_type_class(active_record_class), null: false
            field 'errors', GraphQL::Types::JSON, null: true
            argument active_record_class.primary_key, GraphQL::Types::ID, required: true

            define_method('resolve') do |params|
              unless Gadget::Common::Utility.execute_method_if_exist(active_record_class, true, :gadget_authorization,
                                                                     context, :delete_mutation)
                raise 'access denied'
              end

              params = params.as_json
              instance = active_record_class.find(params[active_record_class.primary_key])
              if instance.destroy
                {
                  success: true,
                  Gadget::Common::Utility.result_field_name(active_record_class) => instance.as_json
                }
              else
                {
                  success: false,
                  Gadget::Common::Utility.result_field_name(active_record_class) => instance,
                  'errors' => Gadget::Common::Utility.make_error_messages(instance.errors)
                }
              end
            end
          end
        end
      end
    end
  end
end
