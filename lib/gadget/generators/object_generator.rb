module Gadget
  class ObjectGenerator < Rails::Generators::Base
    desc "create ObjectType"
    def create_initializer_file
      create_file "config/initializers/initializer.rb", "# イニシャライザの内容をここに記述"
    end
  end
end
