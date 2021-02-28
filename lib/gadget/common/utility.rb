# frozen_string_literal: true

module Gadget
  module Common
    module Utility
      class << self
        def execute_method_if_exist(object, default_value, method_name, *params)
          if object.respond_to?(method_name)
            object.public_send(method_name, *params)
          else
            default_value
          end
        end

        def get_field_type(active_record_class, attribute_name)
          if attribute_name == active_record_class.primary_key
            GraphQL::Types::Int
          elsif active_record_class.defined_enums[attribute_name]
            "Types::#{active_record_class.name}#{attribute_name.camelize}Type".constantize
          else
            attribute_type = active_record_class.attribute_types[attribute_name]
            case attribute_type.type
            when :integer
              column_type = active_record_class.columns_hash[attribute_name]

              if column_type && column_type.sql_type =~ (/^(tinyint|int)/)
                GraphQL::Types::Int
              else
                GraphQL::Types::BigInt
              end
            when :float
              GraphQL::Types::Float
            when :decimal
              if attribute_type.scale.blank?
                if attribute_type.precision.nil? || attribute_type.precision > 10
                  GraphQL::Types::BigInt
                else
                  GraphQL::Types::Int
                end
              else
                GraphQL::Types::Float
              end
            when :boolean
              GraphQL::Types::Boolean
            when :string
              GraphQL::Types::String
            when :text
              GraphQL::Types::String
            when :date
              GraphQL::Types::ISO8601Date
            when :time
              GraphQL::Types::String
            when :datetime
              GraphQL::Types::ISO8601DateTime
            else
              raise "Cannot convert column TYPE to GraphQL TYPE column.type=[#{attribute_type.type}] on #{active_record_class}::#{attribute_name}"
            end
          end
        end

        def get_field_nullability(active_record_class, attribute_name)
          column_type = active_record_class.columns_hash[attribute_name]
          !column_type or column_type.null
        end

        def skip_columns
          %i[created_at created_by updated_at updated_by]
        end

        def make_error_messages(errors)
          errors.map do |key, _error|
            [key, errors.full_messages_for(key)]
          end.to_h
        end

        def generate_input_arguments(instance, active_record_class, _options)
          active_record_class.attribute_names.each do |attribute_name|
            field_name = attribute_name.to_sym
            field_type = Gadget::Common::Utility.get_field_type(active_record_class, attribute_name)
            # required = Gadget::Common::Utility.get_field_nullability(active_record_class, attribute_name)
            instance.argument field_name, field_type, required: false,
                                                      description: active_record_class.human_attribute_name(attribute_name)
          end
          active_record_class.reflections.each do |reflection_name, definition|
            field_name = reflection_name.to_sym
            next unless active_record_class.nested_attributes_options.keys.include?(field_name)

            field_type = "Types::#{definition.klass}InputType".constantize
            if definition.belongs_to? || definition.has_one?
              instance.argument field_name, field_type, required: false, description: definition.klass.model_name.human
            elsif definition.collection?
              instance.argument field_name, [field_type], required: false,
                                                          description: "#{definition.klass.model_name.human}のコレクション"
            end
          end
          yield if block_given?
        end

        #
        # ransackでキャメルケース形式のパラメータを使用できるようにする
        # (define_method内で使用しておりprivateにするとスコープ外で例外が発生するのでpublicにする)
        #
        def camel_to_underscore(params)
          result = {}
          params&.each do |key, val|
            key = key.to_s.underscore
            result[key] = if %w[s sorts].include?(key) && val.instance_of?(String)
                            val.split(/\s+/).map(&:underscore).join(' ').strip
                          elsif %w[s sorts s sorts s sorts].include?(key) && val.instance_of?(Array)
                            val.map { |v| v.split(/\s+/).map(&:underscore).join(' ').strip }
                          elsif %w[s sorts s sorts s sorts s sorts g
                                   groupings].include?(key) && (val.instance_of?(Hash) || val.instance_of?(Array))
                            if val.instance_of?(Hash)
                              val.values.map { |v| camel_to_underscore(v) }
                            else
                              val.map { |v| camel_to_underscore(v) }
                            end
                          else
                            val
                          end
          end
          result
        end

        def result_field_name(active_record_class)
          active_record_class.name.downcase
        end

        def object_type_class(active_record_class)
          "Types::#{active_record_class.name}Type".constantize
        end

        def object_type_class_paginated(active_record_class)
          "Types::#{active_record_class.name}PaginatedType".constantize
        end

        def object_input_type_class(active_record_class)
          "Types::#{active_record_class.name}InputType".constantize
        end

        #
        # コレクション用にクラス名をスネークケースの複数形にして返す
        #
        def collection_name(active_record_class)
          active_record_class.name.underscore.pluralize
        end

        #
        # コレクション用にクラス名をスネークケースの複数形にして返す
        #
        def collection_name_paginated(_active_record_class)
          "#{collection_name}_paginated"
        end
      end
    end
  end
end
