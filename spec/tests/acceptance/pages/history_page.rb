# frozen_string_literal: true

# Page object for history page
class HistoryPage
  include PageObject

  page_url "#{PortfolioAdvisor::App.config.API_HOST}/history/<%=params[:target_name]%>"

  div(:warning_message, id: 'flash_bar_danger')
  div(:success_message, id: 'flash_bar_success')

  h2(:target_title, id: 'target_name')
  table(:historys_table, id: 'history_table')

  indexed_property(
    :historys,
    [
      [:td, :updated_at, { id: 'history.updated_at' }],
      [:td, :market_price, { id: 'history.market_price' }],
      [:td, :long_advice_price, { id: 'history.long_advice_price' }],
      [:td, :mid_advice_price, { id: 'history.mid_advice_price' }],
      [:td, :short_advice_price, { id: 'history.short_advice_price' }]
    ]
  )

  def historys
    historys_table_element.trs(id: 'history_row')
  end
end
