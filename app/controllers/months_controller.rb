class MonthsController < ApplicationController
  def index
    @year = Year.find(params[:year_id])
    @months = @year.months
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
    @month = Month.find(params[:id])
    @year = @month.year
    @operations = @month.operations
  end

  def update
  end

  def destroy
  end
end
