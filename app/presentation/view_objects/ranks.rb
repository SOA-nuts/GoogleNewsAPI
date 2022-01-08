# frozen_string_literal: true

require_relative 'article'

module Views
  # View for a target entities
  class Ranks
    def initialize(ranks)
        @rank_array = ranks.rank.split(',')
    end

    def entity
        @rank_array
    end

    def target_link(company_name)
        "/target/#{company_name}"
    end
  end
end
