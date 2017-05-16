class LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    @auctions = user.liked_auctions
    render 'auctions/index'
  end

  def create
    auction = Auction.find(params[:auction_id])

    if cannot? :like, auction
     redirect_to(
       auction_path(auction),
       alert: 'Liking your own auction is disgusting 🤢'
     )
     return # early return to prevent execution of anything
     # after the redirect above
    end

    like = Like.new(user: current_user, auction: auction)
    if like.save
      redirect_to auction_path(auction), notice: 'Watched Auction! 💖'
    else
      redirect_to auction_path(auction), alert: like.errors.full_messages.join(', ')
    end
  end

  def destroy
    like = Like.find(params[:id])

    if cannot? :like, like.auction
     redirect_to(
       auction_path(auction),
       alert: 'Un-liking your own auction is prepostrous 🤢'
     )
     return
   end

    if like.destroy
      redirect_to auction_path(like.auction), notice: 'Un-watched auction! 💔'
    else
      redirect_to auction_path(like.auction), alert: like.errors.full_messages.join(', ')
    end
  end

end
