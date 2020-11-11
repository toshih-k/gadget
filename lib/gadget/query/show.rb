module Gadget
  module Query
    module Show
      extend ActiveSupport::Concern
      included do
        class << self
          def show(active_record_class)
            field active_record_class.name.underscore, Gadget::Common::Utility.object_type_class(active_record_class), null: true do
              description "show #{active_record_class.name}"
              argument :id, GraphQL::Types::ID, required: true
            end
            define_method(active_record_class.name.underscore) do |id:|
              active_record_class.find(id)
            end
          end
        end
      end
    end
  end
end
