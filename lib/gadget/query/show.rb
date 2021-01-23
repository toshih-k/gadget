module Gadget
  module Query
    module Show
      extend ActiveSupport::Concern
      included do
        class << self
          def show(active_record_class)
            field active_record_class.name.underscore, Gadget::Common::Utility.object_type_class(active_record_class), null: true do
              description "指定されたIDの#{active_record_class.model_name.human}を1件返す"
              argument :id, GraphQL::Types::ID, required: true
            end
            define_method(active_record_class.name.underscore) do |id:|
              unless Gadget::Common::Utility.execute_method_if_exist(active_record_class, true, :gadget_authorization, context, :show_query)
                raise 'access denied'
              end
              relation = Gadget::Common::Utility.execute_method_if_exist(active_record_class, active_record_class, :before_gadget_show_query)
              relation.find(id)
            end
          end
        end
      end
    end
  end
end
