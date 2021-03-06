# frozen_string_literal: true

module Gadget
  module Types
    #
    # base input type object for gadet
    #
    module InputObject
      extend ActiveSupport::Concern
      included do
        class << self
          def from_active_record(active_record_class, options = {})
            description "#{active_record_class.model_name.human}用のInputTypeObject"

            active_record_class.attribute_names.each do |attribute_name|
              field_name = attribute_name.to_sym
              field_type = Gadget::Common::Utility.get_field_type(active_record_class, attribute_name)
              # required = Gadget::Common::Utility.get_field_nullability(active_record_class, attribute_name)
              argument field_name, field_type, required: false,
                                                        description: active_record_class.human_attribute_name(attribute_name)
            end
            active_record_class.reflections.each do |reflection_name, definition|
              field_name = reflection_name.to_sym
              next unless active_record_class.nested_attributes_options.keys.include?(field_name)

              field_type = "Types::#{definition.klass}InputType".constantize
              if definition.belongs_to? || definition.has_one?
                argument field_name, field_type, required: false, description: definition.klass.model_name.human
              elsif definition.collection?
                argument field_name, [field_type], required: false,
                                                            description: "#{definition.klass.model_name.human}のコレクション"
              end
              argument :_destroy, GraphQL::Types::Boolean, required: false
            end
            yield if block_given?
          end
        end
      end
    end
  end
end
