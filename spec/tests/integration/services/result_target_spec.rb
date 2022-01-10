# frozen_string_literal: true

require_relative '../../../helpers/spec_helper'

describe 'Integration test of Target service and API gateway' do
  it 'must get the target data of an existing target' do
    req = OpenStruct.new(
      company_name: TOPIC
    )
    watched_list = [req.company_name]

    # WHEN we request to add a project
    res = PortfolioAdvisor::Service::ResultTarget.new.call(
      watched_list: watched_list, requested: TOPIC
    )

    # THEN we should see a single project in the list
    _(res.success?).must_equal true
    result = res.value!
    _(result.company_name).must_equal TOPIC
    _(result.articles.count).must_equal 15
  end
end
