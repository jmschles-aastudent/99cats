class CatRentalRequestsController < ApplicationController

  def index
    @cat_rentals = CatRentalRequest.where(:cat_id => params[:cat_id])
  end

  def show
    @cat_rental = CatRentalRequest.find(params[:id])
    @cat = Cat.find(@cat_rental.cat_id)
  end

  def create
    status = {:status => 'undecided'}
    params[:cat_rental].merge!(status)
    @cat_rental = CatRentalRequest.new(params[:cat_rental])
    if @cat_rental.save
      redirect_to cat_rental_request_url(@cat_rental)
    else
      flash[:errors] ||= []
      flash[:errors] << "Invalid cat rental!"
      redirect_to new_cat_rental_request_url
    end
  end

  def update
    @cat_rental = CatRentalRequest.find(params[:id])
    @cat = Cat.find(@cat_rental.cat_id)
    if current_user.session_token != @cat.owner.session_token || @cat.owner.session_token.nil?
      flash[:errors] ||= []
      flash[:errors] << "Not yo cat!"
      redirect_to cat_url(@cat)
      return
    end
    @cat_rental.attributes = params[:cat_rental]
    if @cat_rental.save
      @cat_rental.approve if @cat_rental.status == 'approved'
      render :show
    else
      flash[:errors] ||= []
      flash[:errors] << "Invalid cat rental!"
      redirect_to edit_cat_rental_request_url(@cat_rental)
    end

  end

  def new
    @cats = Cat.all
  end

  def edit
    @cat_rental = CatRentalRequest.find(params[:id])
  end

end
