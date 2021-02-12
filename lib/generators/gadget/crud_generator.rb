# frozen_string_literal: true

module Gadget
  class CrudGenerator < Rails::Generators::NamedBase
    class_option :only, type: :array, banner: ''
    class_option :except, type: :array

    ALL_ACTIONS = %w[index show create update delete].freeze

    def check_args
      if options[:only] && ((ALL_ACTIONS | options[:only]).length != ALL_ACTIONS.length)
        puts "allowed [#{ALL_ACTIONS.join(' ')}] in only option"
        exit 1
      end
      if options[:except] && ((ALL_ACTIONS | options[:except]).length != ALL_ACTIONS.length)
        puts "allowed [#{ALL_ACTIONS.join(' ')}] in except option"
        exit 1
      end
    end

    def set_execute_action
      @execute_actions = ALL_ACTIONS
      @execute_actions = options[:only] if options[:only]
      @execute_actions = ALL_ACTIONS - options[:except] if options[:except]
    end

    def create_type
      generate 'gadget:type', name
    end

    def create_index_query
      return unless @execute_actions.include?('index')

      generate 'gadget:index_query', name
    end

    def create_show_query
      return unless @execute_actions.include?('show')

      generate 'gadget:show_query', name
    end

    def create_create_mutation
      return unless @execute_actions.include?('create')

      generate 'gadget:create_mutation', name
    end

    def create_update_mutation
      return unless @execute_actions.include?('update')

      generate 'gadget:update_mutation', name
    end

    def create_delete_mutation
      return unless @execute_actions.include?('delete')

      generate 'gadget:delete_mutation', name
    end
  end
end
