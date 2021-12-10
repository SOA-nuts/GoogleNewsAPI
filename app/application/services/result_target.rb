# frozen_string_literal: true

require 'dry/transaction'

module PortfolioAdvisor
  module Service
    # Analyzes results of a target
    class ResultTarget
      include Dry::Transaction

      step :validate_result_target
      step :reify_result_target
     
      private

      def validate_result_target(input)
        if input[:watched_list].include? input[:requested]
          Success(input)
        else
          Failure('Please first request this target  to be added to your list')
        end
      end

      def reify_result_target(result_target_json)
        Representer::TargetsList.new(OpenStruct.new)
          .from_json(result_target_json)
          .then { |result_target_json| Success(result_target_json) }
      rescue StandardError
        Failure('Error in our target results -- please try again')
      end
    end
  end
end