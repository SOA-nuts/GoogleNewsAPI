# frozen_string_literal: true

require 'dry/transaction'

module PortfolioAdvisor
  module Service
    # Transaction to store target from GoogleNews API to database
    class AddTarget
      include Dry::Transaction

      step :validate_input
      step :request_target
      step :reify_target

      private

      def validate_input(input)
        if input.success?
          company_name = input[:company_name]
          Success(company_name: company_name)
        else
          Failure(input.errors.messages.first)
        end
      end

      def request_target(input)
        input[:response] = Gateway::Api.new(PortfolioAdvisor::App.config)
          .add_target(input[:company_name])
        input[:response].success? ? Success(input) : Failure(input[:response].message)
      rescue StandardError => e
        puts [e.inspect, e.backtrace].flatten.join("\n")
        Failure('Cannot add target right now; please try again later')
      end

      def reify_target(input)
        #   Representer::Target.new(OpenStruct.new)
        #     .from_json(target_json)
        #     .then do |target|
        #     Success(target)
        #   end
        # rescue StandardError => e
        #   puts e.inspect
        #   puts e.backtrace
        #   Failure('Error in add target -- please try again')
        unless input[:response].processing?
          Representer::Target.new(OpenStruct.new)
            .from_json(input[:response].payload)
            .then { input[:added] = _1 }
        end

        Success(input)
      rescue StandardError => e
        puts [e.inspect, e.backtrace].flatten.join("\n")
        Failure('Error on add target -- please try again')
      end
    end
  end
end
