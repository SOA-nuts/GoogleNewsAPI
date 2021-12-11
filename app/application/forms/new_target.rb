# frozen_string_literal: true

require 'dry-validation'
require 'yaml'

COMPANY_YAML = 'spec/fixtures/company.yml'
COMPANY_LIST = YAML.safe_load(File.read(COMPANY_YAML))

module PortfolioAdvisor
  module Forms
    class NewTarget < Dry::Validation::Contract
      params do
        required(:company_name).filled(:string)
      end

      rule(:company_name) do
        key.failure('is a not define company.') if COMPANY_LIST[0][value.downcase].nil?
      end
    end
  end
end
