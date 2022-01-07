# frozen_string_literal: true

require_relative 'article'

module Views
  # View for a target entities
  class Target
    def initialize(target, index = nil)
      @target = target
      @index = index
    end

    def entity
      @target
    end

    def history_link
      "/history/#{company_name}"
    end

    def company_name
      @target.company_name
    end

    def index_str
      "target[#{@index}]"
    end

    def updated_at
      @target.updated_at
    end

    def market_price
      @target.market_price
    end

    def long_term_advice
      @target.short_term_advice
    end

    def mid_term_advice
      @target.mid_term_advice
    end

    def short_term_advice
      @target.short_term_advice
    end

    def articles
      @target.articles.map.with_index { |article, index| Article.new(article, index) }
    end
  end
end
