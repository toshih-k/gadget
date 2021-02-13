# frozen_string_literal: true

module Gadget
  module Types
    #
    # base type object for gadet
    #
    module Object
      extend ActiveSupport::Concern
      included do
        class << self
          def from_active_record(active_record_class)
            description "#{active_record_class.model_name.human}用のTypeObject"
            active_record_class.attribute_names.each do |attribute_name|
              field_name = attribute_name.to_sym
              field_type = Gadget::Common::Utility.get_field_type(active_record_class, attribute_name)
              field field_name, field_type, null: true,
                                            description: active_record_class.human_attribute_name(field_name)
            end
            active_record_class.reflections.each do |reflection_name, definition|
              field_name = reflection_name.to_sym
              field_type = "Types::#{definition.klass}Type".constantize
              if definition.belongs_to? || definition.has_one?
                field field_name, field_type, null: true, description: definition.klass.model_name.human
              elsif definition.collection?
                field field_name, [field_type], null: true, description: "#{definition.klass.model_name.human}のコレクション"
              end
            end

            yield if block_given?
            field :_destroy, GraphQL::Types::Boolean, null: false, description: '削除フラグ'
          end
        end
      end
    end
  end
end
