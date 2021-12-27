# frozen_string_literal: true

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
      "history/#{company_name}"
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

    def long_advice_price
      @target.long_advice_price
    end

    def mid_advice_price
      @target.mid_advice_price
    end

    def short_advice_price
      @target.short_advice_price
    end

    def list_of_articles
      @target.articles
    end
  end
end
