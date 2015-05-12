class FeedEntriesController < ApplicationController
  def matched
    @alert = Alert.find(params[:alert_id])
    @date_range = DateRange.new(params[:from].to_datetime, params[:to].to_datetime)
    search_options = Alert.search_options([@alert], @date_range)

    search_result = FeedEntry.search(search_options)
    @search_highlight = search_result.results
  end

  def show
    from = params[:from]
    to  = params[:to]
    @date_range = DateRange.new(from, to)
    @alert = Alert.find(params[:alert_id])
    @feed_entry = FeedEntry.find(params[:id])
  end

  def embed
    @alert = Alert.find(params[:alert_id])
    @feed_entry = FeedEntry.find(params[:id])
    render layout: false
  end
end