class SharesController < ApplicationController
  before_action :set_share, only: %i[update]

  def index
    @shares = Share.all
    json_response(@shares)
  end

  def create
    @share = Share.new(share_params)
    if @share.save
      json_response(@share)
    else
      json_error_response(@share.errors)
    end
  end

  def update
    if @share.present?
      if @share.update(share_params)
        json_response(@share)
      else
        json_error_response(@share.errors)
      end
    else
      json_error_response("Record not found")
    end
  end

  def create_subscription
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      json_response(@subscription)
    else
      json_error_response(@subscription.errors)
    end
  end

  private
    def set_share
      @share = Share.find_by(id: params[:id])
    end

    def share_params
      params.require(:share).permit(:name, :symbol, :price)
    end

    def subscription_params
      params.require(:subscription).permit(:callback_url, :api_key)
    end
end
