module Gadget
  module Types
    module InputObject
      extend ActiveSupport::Concern
      included do
        class << self
          def from_active_record(active_record_class)
            description "input object for #{active_record_class.name}"
            active_record_class.columns.each do |column|
              field_name = column.name.to_sym
              field_type = Gadget::Common::Utility.get_field_type(active_record_class, column)
              argument field_name, field_type, required: false
            end
            active_record_class.reflections.each do |reflection_name, definition|
              field_name = reflection_name.to_sym
              next unless active_record_class.nested_attributes_options.keys.include?(field_name)

              field_type = "Types::#{definition.klass}InputType".constantize
              case
              when (definition.belongs_to? or definition.has_one?)
                argument field_name, field_type, required: false
              when (definition.collection?)
                argument field_name, [field_type], required: false
              end
            end

            yield if block_given?
            argument :_destroy, GraphQL::Types::Boolean, required: false
          end
        end
      end
    end
  end
end
