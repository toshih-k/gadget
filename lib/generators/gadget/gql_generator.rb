module Gadget
  class GqlGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('templates', __dir__)

    class_option :only, type: :array, banner: ""
    class_option :except, type: :array

    ALL_ACTIONS = ["index", "show", "create", "update", "delete"]

    def check_args
      if options[:only] and (ALL_ACTIONS | options[:only]).length != ALL_ACTIONS.length
        puts "allowed [#{ALL_ACTIONS.join(" ")}] in only option"
        exit 1
      end
      if options[:except] and (ALL_ACTIONS | options[:except]).length != ALL_ACTIONS.length
        puts "allowed [#{ALL_ACTIONS.join(" ")}] in except option"
        exit 1
      end
    end

    def check_model_existance
      raise "Cannot find model #{name}" unless Module.const_defined?(name)
    end

    def set_execute_action
      @execute_actions = ALL_ACTIONS
      if options[:only]
        @execute_actions = options[:only]
      end
      if options[:except]
        @execute_actions = ALL_ACTIONS - options[:except]
      end
    end

    def create_index_gql
      return unless @execute_actions.include?("index")
      template('gql/index_query.gql.tt', "tmp/gql/queries/#{name.pluralize[0].downcase}#{name.pluralize[1..]}.gql", { name: name })
    end

    def create_show_gql
      return unless @execute_actions.include?("show")
      template('gql/show_query.gql.tt', "tmp/gql/queries/#{name[0].downcase}#{name[1..]}.gql", { name: name })
    end

    def create_create_gql
      return unless @execute_actions.include?("create")
      template('gql/create_mutation.gql.tt', "tmp/gql/mutations/create#{name}.gql", { name: name })
    end

    def create_update_gql
      return unless @execute_actions.include?("update")
      template('gql/update_mutation.gql.tt', "tmp/gql/mutations/update#{name}.gql", { name: name })
    end

    def create_delete_gql
      return unless @execute_actions.include?("delete")
      template('gql/delete_mutation.gql.tt', "tmp/gql/mutations/delete#{name}.gql", { name: name })
    end

  end
end