module Gadget
  class Railtie < ::Rails::Railtie
    initializer 'gadget' do |app|
      ActiveSupport.on_load :action_view do
        require 'gadget/common/utility'
        require 'gadget/types/object'
        require 'gadget/types/input_object'
        require 'gadget/query/index'
        require 'gadget/query/show'
        require 'gadget/mutation/create'
        require 'gadget/mutation/update'
        require 'gadget/mutation/delete'
      end
    end
  end
end
