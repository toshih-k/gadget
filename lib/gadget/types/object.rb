module Gadget
  module Types
    module Object
      extend ActiveSupport::Concern
      included do
        class << self
          def from_active_record(active_record_class)
            description active_record_class.name
            active_record_class.attribute_names.each do |attribute_name|
              field_name = attribute_name.to_sym
              field_type = Gadget::Common::Utility.get_field_type(active_record_class, attribute_name)
              nullable = Gadget::Common::Utility.get_field_nullability(active_record_class, attribute_name)
              field field_name, field_type, null: nullable
            end
            active_record_class.reflections.each do |reflection_name, definition|
              field_name = reflection_name.to_sym
              field_type = "Types::#{definition.klass}Type".constantize
              case
              when (definition.belongs_to? or definition.has_one?)
                field field_name, field_type, null: true
              when (definition.collection?)
                field field_name, [field_type], null: true
              end
            end

            yield if block_given?
            field :_destroy, GraphQL::Types::Boolean, null: false
          end
        end
      end
    end
  end
end
