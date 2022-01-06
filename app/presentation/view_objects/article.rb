# frozen_string_literal: true

require 'date'

module Views
  # View for a list of target entities
  class Article
    def initialize(article, index = nil)
      @article = article
      @index = index
    end

    def published_at(&block)
      @targets.each(&block)
    end

    def title
        @article.title
    end

    def url
        @article.url
    end
    
    def published_at
        datetime = DateTime.strptime(@article.published_at, '%Y-%m-%d')
        datetime.strftime('%Y-%m-%d')
    end

  end
end
