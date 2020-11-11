module Gadget
  module Query
    module Index
      extend ActiveSupport::Concern
      included do
        class << self
          def index(active_record_class)
            field Gadget::Common::Utility.collection_name(active_record_class).to_sym, [Gadget::Common::Utility.object_type_class(active_record_class)], null: false do
              description "list #{active_record_class.name}"
              argument :q, GraphQL::Types::JSON, required: false
            end
            define_method(Gadget::Common::Utility.collection_name(active_record_class)) do |q: nil, page: nil, per: nil|
              relation = active_record_class
              if active_record_class.respond_to?(:before_index_query)
                relation = active_record_class.before_index_query
              end
              q = relation.ransack(Gadget::Common::Utility.camel_to_underscore(q))
              q.result
            end
          end
        end
      end
    end
  end
end
