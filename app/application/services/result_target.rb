# frozen_string_literal: true

require 'dry/transaction'

module PortfolioAdvisor
  module Service
    # Analyzes results of a target
    class ResultTarget
      include Dry::Transaction

      step :validate_target
      step :retrieve_target
      step :reify_target
     
      private

      def validate_target(input)
        if input[:watched_list].include? input[:requested]
          Success(input)
        else
          Failure('Please first request this target  to be added to your list')
        end
      end

      def retrieve_target(input)
        result = Gateway::Api.new(PortfolioAdvisor::App.config)
          .result_target(input[:requested])
        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError
        Failure('Cannot get target right now; please try again later')
      end

      def reify_target(result_target_json)
        Representer::Target.new(OpenStruct.new)
          .from_json(result_target_json)
          .then { |result_target_json| Success(result_target_json) }
      rescue StandardError
        Failure('Error in our target results -- please try again')
      end
    end
  end
end