# frozen_string_literal: true

module Gadget
  module Query
    module Index
      extend ActiveSupport::Concern
      included do
        class << self
          class_attribute :before_find_methods
          class_attribute :after_find_methods

          self.before_find_methods = []
          self.after_find_methods = []

          def before_find(name)
            self.before_find_methods << name
          end
          def after_find(name)
            self.after_find_methods << name
          end

          def index_query_from(active_record_class, options = {})
            name = options[:name] || Gadget::Common::Utility.collection_name(active_record_class).to_sym
            paginate = options[:paginate]
            if paginate
              desc = "#{active_record_class.model_name.human}の一覧をページ指定して取得する"
              result_type_def = "Types::#{active_record_class.name}PaginatedType".constantize
            else
              desc = "#{active_record_class.model_name.human}の一覧を取得する"
              result_type_def = [Gadget::Common::Utility.object_type_class(active_record_class)]
            end
            description desc
            type result_type_def, null: true
            argument :q, GraphQL::Types::JSON, required: false, description: '検索用のransackパラメータ'
            if paginate
              argument :page, GraphQL::Types::Int, required: false, description: 'ページ番号(未指定時は最初のページを返す)'
              argument :per, GraphQL::Types::Int, required: true, description: '1ページごとの表示数'
            end

            define_method(:resolve) do |q: nil, page: nil, per: nil|
              unless Gadget::Common::Utility.execute_method_if_exist(active_record_class, true, :gadget_authorization,
                                                                     context, :index_query)
                raise 'access denied'
              end

              relation = Gadget::Common::Utility.execute_method_if_exist(active_record_class, active_record_class,
                                                                         :before_gadget_index_query)
              self.class.before_find_methods.each do |method_name|
                relation = send method_name, relation
              end
              q = relation.ransack(Gadget::Common::Utility.camel_to_underscore(q))
              result = q.result
              self.class.after_find_methods.each do |method_name|
                result = send method_name, result
              end
              if paginate
                result = result.page(page).per(per)
                {
                  records: result,
                  total_count: result.total_count,
                  current_page: result.current_page,
                  per_page: result.limit_value
                }
              end
              result
            end
          end
        end
      end
    end
  end
end
