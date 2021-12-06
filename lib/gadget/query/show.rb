# frozen_string_literal: true

module Gadget
  module Query
    module Show
      extend ActiveSupport::Concern
      included do
        class << self
          class_attribute :after_find_methods

          self.after_find_methods = []

          def after_find(name)
            self.after_find_methods << name
          end

          def show_query_from(active_record_class, options = {})
            name = options[:name] || active_record_class.name.underscore

            description "指定されたIDの#{active_record_class.model_name.human}を1件返す"
            type Gadget::Common::Utility.object_type_class(active_record_class), null: true
            argument :id, GraphQL::Types::ID, required: true

            define_method(:resolve) do |id:|
              unless Gadget::Common::Utility.execute_method_if_exist(active_record_class, true, :gadget_authorization,
                                                                     context, :show_query)
                raise 'access denied'
              end

              relation = Gadget::Common::Utility.execute_method_if_exist(active_record_class, active_record_class,
                                                                         :before_gadget_show_query)
              result = relation.find(id)
              self.class.after_find_methods.each do |method_name|
                result = send method_name, result
              end
              result
            end
          end
        end
      end
    end
  end
end
