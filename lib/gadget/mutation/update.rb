# frozen_string_literal: true

module Gadget
  module Mutation
    module Update
      extend ActiveSupport::Concern
      included do
        class << self
          def update_mutation_for(active_record_class, options = {})
            description "#{active_record_class.model_name.human}を更新する"
            field 'success', GraphQL::Types::Boolean, null: false
            field Gadget::Common::Utility.result_field_name(active_record_class),
                  Gadget::Common::Utility.object_type_class(active_record_class), null: false
            field 'errors', GraphQL::Types::JSON, null: true
            Gadget::Common::Utility.generate_input_arguments(self, active_record_class, options) do
              yield if block_given?
            end

            define_method('resolve') do |params|
              unless Gadget::Common::Utility.execute_method_if_exist(active_record_class, true, :gadget_authorization,
                                                                     context, :update_mutation)
                raise 'access denied'
              end

              params = params.as_json
              input_name = Gadget::Common::Utility.input_field_name(active_record_class)
              input_attributes = params[input_name]
              validation_context = params['validation_context']

              attributes = Gadget::Common::Utility.to_active_record_input(input_attributes, active_record_class)

              instance = active_record_class.find(input_attributes['id'])
              instance.attributes = attributes

              if validation_context.nil?
                success = instance.save
              else
                success = instance.valid?(validation_context)
              end

              result = {
                success: success,
                Gadget::Common::Utility.result_field_name(active_record_class).to_sym => instance.as_json
              }
              unless success
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
