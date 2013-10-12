class CatRentalRequestsController < ApplicationController
	before_filter only: [:approve, :deny] { |c| c.check_ownership(cats_url) }

  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(params[:cat_rental_request])
    if @cat_rental_request.save
      redirect_to cats_url
    else
       p @cat_rental_request.errors
      render :new
    end
  end

  def approve
   @cat_rental_request = CatRentalRequest.find(params[:cat_rental_request_id])
   @cat_rental_request.overlapping_pending_requests
   redirect_to cat_url(@cat_rental_request.cat_id)
  end

  def deny
    @cat_rental_request = CatRentalRequest.find(params[:cat_rental_request_id])
    @cat_rental_request.deny!

    redirect_to cat_url(@cat_rental_request.cat_id)
  end



end
