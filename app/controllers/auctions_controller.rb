class AuctionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show]

  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new auction_params
    @auction.user = current_user
    if @auction.save
      redirect_to auction_path(@auction), notice: 'Auction created successfuly!'
    else
      render :new
    end
  end

  def show
    @auction = Auction.find params[:id]
    @bid = Bid.new
  end

  private

  def auction_params
    params.require(:auction).permit(:title, :details, :ends_on, :reserve_price)
  end


end
