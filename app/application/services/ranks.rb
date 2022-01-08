# frozen_string_literal: true

require 'dry/transaction'

module PortfolioAdvisor
  module Service
    # Analyzes history results of a target
    class Ranks
      include Dry::Transaction

      step :get_rank
      step :reify_history

      private

      def get_rank(input)
        result = Gateway::Api.new(PortfolioAdvisor::App.config)
          .result_rank
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
          end
      rescue StandardError => e
        puts e.inspect
        puts e.backtrace
        Failure('Error in our rank results -- please try again')
      end

      def reify_history(result_rank_json)
        Representer::Ranks.new(OpenStruct.new)
          .from_json(result_rank_json)
          .then { |result_rank| Success(result_rank) }
      rescue StandardError => e
        puts e.inspect
        puts e.backtrace
        Failure('Error in our rank results -- please try again')
      end
    end
  end
end
