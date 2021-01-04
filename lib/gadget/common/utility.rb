module Gadget
  module Common
    module Utility
      class << self
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

              if column_type and column_type.sql_type =~ /^(tinyint|int)/
                GraphQL::Types::Int
              else
                GraphQL::Types::BigInt
              end
            when :float
              GraphQL::Types::Float
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
              raise "Cannot convert column TYPE to GraphQL TYPE column.type=[#{column.type}]"
            end
          end
        end

        def get_field_nullability(active_record_class, attribute_name)
          column_type = active_record_class.columns_hash[attribute_name]
          !column_type or column_type.null
        end

        def skip_columns
          [:created_at, :created_by, :updated_at, :updated_by]
        end

        def generate_input_arguments(instance, active_record_class, options)
          active_record_class.attribute_names.each do |attribute_name|
            field_name = attribute_name.to_sym
            field_type = Gadget::Common::Utility.get_field_type(active_record_class, attribute_name)
            # required = Gadget::Common::Utility.get_field_nullability(active_record_class, attribute_name)
            instance.argument field_name, field_type, required: false, description: active_record_class.human_attribute_name(attribute_name)
          end
          active_record_class.reflections.each do |reflection_name, definition|
            field_name = reflection_name.to_sym
            next unless active_record_class.nested_attributes_options.keys.include?(field_name)

            field_type = "Types::#{definition.klass}InputType".constantize
            case
            when (definition.belongs_to? or definition.has_one?)
              instance.argument field_name, field_type, required: false, description: definition.klass.model_name.human
            when (definition.collection?)
              instance.argument field_name, [field_type], required: false, description: "#{definition.klass.model_name.human}のコレクション"
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
          unless params.nil?
            params.each do |key, val|
              key = key.to_s.underscore
              if (key == 's' || key == 'sorts') && val.instance_of?(String)
                result[key] = val.split(/\s+/).map(&:underscore).join(' ').strip
              elsif (key == 's' || key == 'sorts') && val.instance_of?(Array)
                result[key] = val.map { |v| v.split(/\s+/).map(&:underscore).join(' ').strip }
              elsif (key == 'g' || key == 'groupings') && (val.instance_of?(Hash) || val.instance_of?(Array))
                if val.instance_of?(Hash)
                  result[key] = val.values.map { |v| camel_to_underscore(v) }
                else
                  result[key] = val.map { |v| camel_to_underscore(v) }
                end
              else
                result[key] = val
              end
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
        def collection_name_paginated(active_record_class)
          "#{collection_name}_paginated"
        end
      end
    end
  end
end