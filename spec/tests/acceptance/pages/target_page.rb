# frozen_string_literal: true

# Page object for target page
class TargetPage
  include PageObject

  page_url "#{PortfolioAdvisor::App.config.API_HOST}/target/<%=params[:target_name]%>"

  div(:warning_message, id: 'flash_bar_danger')
  div(:success_message, id: 'flash_bar_success')

  h2(:target_title, id: 'target_name')
  table(:articles_table, id: 'articles_table')

  indexed_property(
    :articles,
    [
      [:td, :title, { id: 'article.title' }],
      [:td, :updated_at, { id: 'article.updated_at' }]
    ]
  )

  def articles
    articles_table_element.trs(id: 'article_row')
  end
end
