module Gadget
  class ShowQueryGenerator < Rails::Generators::NamedBase
    def create_type
      generate "gadget:type", name
    end

    def modify_query
      inject_into_file "app/graphql/types/query_type.rb", "    show #{name}\n", before: "  end\nend\n"
    end
  end
end