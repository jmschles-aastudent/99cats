class CatsController < ApplicationController

  def index
    @cats = Cat.all

    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    @rental_requests = CatRentalRequest.where( :cat_id => @cat.id )
    @rental_requests.sort_by! {|request| request.begin_date }
    render :show
  end

  def create
    @cat = Cat.new(params[:cat])
    if @cat.save
      render :show
    else
      flash[:errors] ||= []
      flash[:errors] << "Bad cat!"
      redirect_to new_cat_url
    end
  end

  def update
    @cat = Cat.find(params[:id])
    # @cat.attributes = params[:cat]
    if @cat.update_attributes(params[:cat])
      render :show
    else
      flash[:errors] ||= []
      flash[:errors] << "Bad cat!"
      redirect_to edit_cat_url(@cat)
    end

  end

  def new
  end

  def edit
    @cat = Cat.find(params[:id])
  end

end
