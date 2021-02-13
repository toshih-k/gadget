# frozen_string_literal: true

module Gadget
  module Generators
    #
    # generate sample gqls
    #
    class GqlGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      class_option :only, type: :array, banner: ''
      class_option :except, type: :array

      ALL_ACTIONS = %w[index show create update delete].freeze

      def check_args
        %i[only except].each do |opt_name|
          next if options[:opt_name]

          actions_merged = ALL_ACTIONS | options[opt_name]
          raise "allowed [#{ALL_ACTIONS.join(' ')}] in #{opt_name} option" if actions_merged.length != ALL_ACTIONS.length
        end
      end

      def check_model_existance
        raise "Cannot find model #{name}" unless Module.const_defined?(name)
      end

      def set_execute_action
        @execute_actions = ALL_ACTIONS
        @execute_actions = options[:only] if options[:only]
        @execute_actions = ALL_ACTIONS - options[:except] if options[:except]
      end

      def create_index_gql
        return unless @execute_actions.include?('index')

        template('gql/index_query.gql.tt', "tmp/gql/queries/#{name.pluralize[0].downcase}#{name.pluralize[1..]}.gql",
                { name: name })
      end

      def create_show_gql
        return unless @execute_actions.include?('show')

        template('gql/show_query.gql.tt', "tmp/gql/queries/#{name[0].downcase}#{name[1..]}.gql", { name: name })
      end

      def create_create_gql
        return unless @execute_actions.include?('create')

        template('gql/create_mutation.gql.tt', "tmp/gql/mutations/create#{name}.gql", { name: name })
      end

      def create_update_gql
        return unless @execute_actions.include?('update')

        template('gql/update_mutation.gql.tt', "tmp/gql/mutations/update#{name}.gql", { name: name })
      end

      def create_delete_gql
        return unless @execute_actions.include?('delete')

        template('gql/delete_mutation.gql.tt', "tmp/gql/mutations/delete#{name}.gql", { name: name })
      end
    end
  end
end
