class Queries::Books < Queries::BaseQuery
  include Gadget::Query::Index

  index_query_from ::Book
end
