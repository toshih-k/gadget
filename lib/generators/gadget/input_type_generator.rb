module Gadget
  class InputTypeGenerator < Rails::Generators::NamedBase
    def create_type_file
      create_file "app/graphql/types/#{file_name}_input_type.rb", <<EOS
module Types
  class #{name}InputType < Types::BaseInputObject
    from_active_record #{name}
  end
end
EOS
    end
  end
end