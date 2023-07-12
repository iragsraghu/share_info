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


  private
    def set_share
      @share = Share.find_by(id: params[:id])
    end

    def share_params
      params.require(:share).permit(:name, :symbol, :price)
    end
end
