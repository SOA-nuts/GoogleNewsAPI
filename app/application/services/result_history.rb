# frozen_string_literal: true

require 'dry/transaction'

module PortfolioAdvisor
  module Service
    # Analyzes history results of a target
    class ResultHistory
      include Dry::Transaction

      step :validate_result_history
      step :reify_result_history

      private

      def validate_result_history(input)
        if input[:watched_list].include? input[:requested]
          Success(input)
        else
          Failure('Please first request this history to be added to your list')
        end
      end
    
        def reify_result_history(result_history_json)
        Representer::HistoriesList.new(OpenStruct.new)
          .from_json(result_history_json)
          .then { |result_history| Success(result_history) }
      rescue StandardError
        Failure('Error in our history results -- please try again')
      end
    end
  end
end