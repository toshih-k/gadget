module Gadget
  class TypeGenerator < Rails::Generators::NamedBase
    def create_type_file
      create_file "app/graphql/types/#{file_name}_type.rb", <<EOS
module Types
  class #{name}Type < Types::BaseObject
    from_active_record #{name}
  end
end
EOS
    end
  end
end