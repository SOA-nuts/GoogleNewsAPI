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
      @target.long_term_advice
    end

    def mid_term_advice
      @target.mid_term_advice
    end

    def short_term_advice
      @target.short_term_advice
    end

    def return_img(advice)
      case advice
      when "bad"
        "https://i.imgur.com/m0ig4VF.png"
      when "poor"
        "https://i.imgur.com/OZdsudC.png"
      when "fair"
        "https://i.imgur.com/wOMl4ia.png"
      when "good"
        "https://i.imgur.com/rwp4Nit.png"
      when "excellent"
        "https://i.imgur.com/q1OTEZx.png"
      end
    end

    def articles
      @target.articles.map.with_index { |article, index| Article.new(article, index) }
    end
  end
end
