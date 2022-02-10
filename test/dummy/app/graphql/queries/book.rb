class Queries::Book < Queries::BaseQuery
  include Gadget::Query::Show

  show_query_from ::Book
end
