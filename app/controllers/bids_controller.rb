class BidsController < ApplicationController
  before_action :authenticate_user!

  def create
    @auction = Auction.find params[:auction_id]
    @bid = Bid.new bid_params
    @bid.auction = @auction
    @bid.user = current_user

    if @bid.save 
       redirect_to auction_path(@auction), notice: 'Bid Created!'
     else
       render 'auctions/show'
     end

  end


  private

  def bid_params
    params.require(:bid).permit(:price)
  end

end
