module Gadget
  module Query
    module Index
      extend ActiveSupport::Concern
      included do
        class << self
          def index(active_record_class)
            field Gadget::Common::Utility.collection_name(active_record_class).to_sym, [Gadget::Common::Utility.object_type_class(active_record_class)], null: false do
              description "#{active_record_class.model_name.human}の一覧をページ指定して取得する"
              argument :q, GraphQL::Types::JSON, required: false, description: "検索用のransackパラメータ"
              argument :page, GraphQL::Types::Int, required: false, description: "ページ番号(未指定時は最初のページを返す)"
              argument :per, GraphQL::Types::Int, required: true, description: "1ページごとの表示数"
            end
            define_method(Gadget::Common::Utility.collection_name(active_record_class)) do |q: nil, page: nil, per: nil|
              unless Gadget::Common::Utility.execute_method_if_exist(active_record_class, true, :gadget_authorization, context, :index_query)
                raise 'access denied'
              end
              relation = Gadget::Common::Utility.execute_method_if_exist(active_record_class, active_record_class, :before_gadget_index_query)
              q = relation.ransack(Gadget::Common::Utility.camel_to_underscore(q))
              q.result
            end
          end
        end
      end
    end
  end
end
