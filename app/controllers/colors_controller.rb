class ColorsController < ApplicationController
  before_action :set_color, only: [:show, :edit, :update, :destroy]

  def index
    @colors = Color.all
  end

  def new
    @color = Color.new
  end

  def edit

  end

  def create
    @color = Color.new(color_params)
    if @color.save
      flash[:success] = t('flash.success')
      redirect_to colors_path
    else
      flash.now[:danger] = t('flash.danger')
      render action: :new
    end
  end

  def update
    if @color = Color.update(color_params)
      flash[:success] = t('flash.success')
      redirect_to colors_path
    else
      flash.now[:danger] = t('flash.danger')
      render action: :edit
    end
  end

  def destroy
    @color.destroy
    flash[:success] = t('flash.success')
    redirect_to colors_path
  end

  private

    def set_color
      @color = Color.find(params[:id])
    end

    def color_params
      params.require(:color).permit(:name, :code)
    end
end
