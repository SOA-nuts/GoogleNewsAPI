# frozen_string_literal: true

module Views
  # View for a single history
  class History
    def initialize(history)
      @history = history
    end

    def entity
      @history
    end

    def updated_at
      @history.updated_at
    end

    def market_price
      @history.market_price
    end

    def long_advice_price
      @history.long_advice_price
    end

    def mid_advice_price
      @history.mid_advice_price
    end

    def short_advice_price
      @history.short_advice_price
    end
  end
end
