class CatsController < ApplicationController
	# before_filter :check_ownership, only: [:edit, :update]
	before_filter only: [:edit, :update] { |controller| controller.check_ownership(cats_url) }

	def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
		@owned = @cat.owner == current_user
    @requests = CatRentalRequest.where(:cat_id => params[:id])
    render :show => @cat
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(params[:cat])
		@cat.user_id = current_user.id

    if @cat.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(params[:cat])
      redirect_to cats_url
    else
      render :edit
    end
  end

  def destroy

  end

end
