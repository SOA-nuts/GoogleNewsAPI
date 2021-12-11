# frozen_string_literal: true

require 'dry/transaction'

module PortfolioAdvisor
  module Service
    # Analyzes history results of a target
    class ResultHistory
      include Dry::Transaction

      step :validate_history
      step :get_history
      step :reify_history

      private

      def validate_history(input)
        if input[:watched_list].include? input[:requested]
          Success(input)
        else
          Failure('Please first request this history to be added to your list')
        end
      end

      def get_history(input)
        result = Gateway::Api.new(PortfolioAdvisor::App.config)
          .result_history(input[:requested])
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
          end
      rescue StandardError => e
        puts e.inspect
        puts e.backtrace
        Failure('Error in our history results -- please try again')
      end

      def reify_history(result_history_json)
        Representer::HistoriesList.new(OpenStruct.new)
          .from_json(result_history_json)
          .then { |result_history| Success(result_history) }
      rescue StandardError => e
        puts e.inspect
        puts e.backtrace
        Failure('Error in our history results -- please try again')
      end
    end
  end
end
