# frozen_string_literal: true

require 'dry/transaction'

module PortfolioAdvisor
  module Service
    # Retrieves array of all listed target entities
    class ListTargets
      include Dry::Transaction

      step :get_target_list
      step :reify_target_list

      private

      def get_target_list(targets_list)
        Gateway::Api.new(PortfolioAdvisor::App.config)
          .target_list(targets_list)
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
          end
      rescue StandardError
        Failure(targets_list)
      end

      def reify_target_list(targets_json)
        Representer::TargetsList.new(OpenStruct.new)
          .from_json(targets_json)
          .then { |targets| Success(targets) }
      rescue StandardError
        Failure('Could not parse response from API')
      end
    end
  end
end
