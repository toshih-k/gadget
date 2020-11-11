module Gadget
  module Mutation
    module Update
      extend ActiveSupport::Concern
      included do
        class << self
          def update(active_record_class)
            description "update #{active_record_class.name}"
            field Gadget::Common::Utility.result_field_name(active_record_class), Gadget::Common::Utility.object_type_class(active_record_class), null: false
            field "errors", GraphQL::Types::JSON, null: true
            active_record_class.columns.each do |column|
              field_name = column.name.to_sym
              next if Gadget::Common::Utility.skip_columns.include? field_name

              field_type = Gadget::Common::Utility.get_field_type(active_record_class, column)
              argument field_name, field_type, required: false
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
              instance = active_record_class.find(params[:id])
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


