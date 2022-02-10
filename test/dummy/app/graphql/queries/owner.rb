class Queries::Owner < Queries::BaseQuery
  include Gadget::Query::Show

  show_query_from ::Owner
end
