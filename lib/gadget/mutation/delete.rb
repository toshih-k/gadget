# frozen_string_literal: true

module Gadget
  module Mutation
    module Delete
      extend ActiveSupport::Concern
      included do
        class << self
          class_attribute :after_delete_methods

          self.after_delete_methods = []

          def after_delete(name)
            self.after_delete_methods << name
          end

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
              success = instance.destroy
              result = {
                success: success,
                Gadget::Common::Utility.result_field_name(active_record_class).to_sym => instance.as_json
              }
              if success
                self.class.after_delete_methods.each do |method_name|
                  send method_name, instance
                end
              else
                result['errors'] = Gadget::Common::Utility.make_error_messages(instance.errors)
              end
              result
            end
          end
        end
      end
    end
  end
end
