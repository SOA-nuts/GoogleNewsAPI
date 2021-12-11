# frozen_string_literal: true

require_relative '../../helpers/spec_helper'

describe 'Integration test of AddTarget service and API gateway' do
  it 'must add a legitimate target' do
    # WHEN we request to add a target
    target_request = PortfolioAdvisor::Forms::NewTarget.new.call(company_name: TOPIC)

    res = PortfolioAdvisor::Service::AddTarget.new.call(target_request)

    # THEN we should see a single project in the list
    _(res.success?).must_equal true
    taregt = res.value!
    _(taregt.company_name).must_equal TOPIC
  end
end
