# frozen_string_literal: true

require_relative '../../helpers/spec_helper.rb'

describe 'Unit test of Portfolio Advisor API gateway' do
  it 'must report alive status' do
    alive = PortfolioAdvisor::Gateway::Api.new(PortfolioAdvisor::App.config).alive?
    _(alive).must_equal true
  end

  it 'must be able to add a target' do
    res = PortfolioAdvisor::Gateway::Api.new(PortfolioAdvisor::App.config)
      .add_target(TOPIC)

    _(res.success?).must_equal true
    _(res.parse.keys.count).must_be :>=, 2
  end

  it 'must return a list of targets' do
    # GIVEN a target is in the database
    PortfolioAdvisor::Gateway::Api.new(PortfolioAdvisor::App.config)
      .add_target(TOPIC)

    # WHEN we request a list of targets
    list = [TOPIC]
    res = PortfolioAdvisor::Gateway::Api.new(PortfolioAdvisor::App.config)
      .target_list(list)

    # THEN we should see a single project in the list
    _(res.success?).must_equal true
    data = res.parse
    _(data.keys).must_include 'targets'
    _(data['targets'].count).must_equal 1
    puts data['targets'].first.keys.count
    _(data['targets'].first.keys.count).must_be :>=, 2
  end

  #it 'must return a project appraisal' do
    # GIVEN a project is in the database
    #CodePraise::Gateway::Api.new(CodePraise::App.config)
      #.add_project(USERNAME, PROJECT_NAME)

    # WHEN we request an appraisal
    #req = OpenStruct.new(
     # project_fullname: USERNAME + '/' + PROJECT_NAME,
      #owner_name: USERNAME,
      #project_name: PROJECT_NAME,
      #foldername: ''
    #)

   # res = CodePraise::Gateway::Api.new(CodePraise::App.config)
     # .appraise(req)

    # THEN we should see a single project in the list
   # _(res.success?).must_equal true
    #data = res.parse
    #_(data.keys).must_include 'project'
    #_(data.keys).must_include 'folder'
  #end
end