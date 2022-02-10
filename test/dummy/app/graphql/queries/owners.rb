class Queries::Owners < Queries::BaseQuery
  include Gadget::Query::Index

  index_query_from ::Owner
end
