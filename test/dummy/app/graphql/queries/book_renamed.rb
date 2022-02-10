class Queries::BookRenamed < Queries::BaseQuery
  include Gadget::Query::Show

  show_query_from ::Book
end
