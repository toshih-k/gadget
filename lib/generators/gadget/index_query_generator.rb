module Gadget
  class IndexQueryGenerator < Rails::Generators::NamedBase
    def create_type
      generate "gadget:type", name
    end

    def modify_index_query
      inject_into_file "app/graphql/types/query_type.rb", "    index #{name}\n", before: "  end\nend\n"
    end
  end
end