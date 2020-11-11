module Gadget
  module Mutation
    module Create
      extend ActiveSupport::Concern
      included do
        class << self
          def create(active_record_class)
            description "create #{active_record_class.name}"
            field Gadget::Common::Utility.result_field_name(active_record_class), Gadget::Common::Utility.object_type_class(active_record_class), null: false
            field "errors", GraphQL::Types::JSON, null: true

            that = self
            active_record_class.columns.each do |column|
              next if active_record_class.primary_key == column.name

              field_name = column.name.to_sym
              next if Gadget::Common::Utility.skip_columns.include? field_name
              p that
              field_type = Gadget::Common::Utility.get_field_type(active_record_class, column)
              that.argument field_name, field_type, required: (not(column.null) and column.default.nil?)
            end

            active_record_class.reflections.each do |reflection_name, definition|
              field_name = reflection_name.to_sym
              case
              when (definition.has_one?)
                field_type = "Types::#{definition.klass}InputType".constantize
                argument field_name, field_type, required: false
              end
            end

            define_method("resolve") do |params|
              instance = active_record_class.new(params)
              instance.save
              if instance.save
                {
                  Gadget::Common::Utility.result_field_name(active_record_class) => instance
                }
              else
                {
                  Gadget::Common::Utility.result_field_name(active_record_class) => instance, "errors" => instance.errors.full_messages
                }
              end
            end
          end
        end
      end
    end
  end
end
