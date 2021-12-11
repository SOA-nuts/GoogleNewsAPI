# frozen_string_literal: true

require_relative '../../helpers/spec_helper'

describe 'Integration test of ListTargets service and API gateway' do
  it 'must return a list of targets' do
    # GIVEN a target is in the database
    PortfolioAdvisor::Gateway::Api.new(PortfolioAdvisor::App.config)
      .add_target(TOPIC)

    # WHEN we request a list of targets
    list = [TOPIC]
    res = PortfolioAdvisor::Service::ListTargets.new.call(list)

    # THEN we should see a single project in the list
    _(res.success?).must_equal true
    list = res.value!
    _(list.targets.count).must_equal 1
    _(list.targets.first.company_name).must_equal TOPIC
  end

  it 'must return and empty list if we specify none' do
    # WHEN we request a list of projects
    list = []
    res = PortfolioAdvisor::Service::ListTargets.new.call(list)

    # THEN we should see a no projects in the list
    _(res.success?).must_equal true
    list = res.value!
    _(list.targets.count).must_equal 0
  end
end
