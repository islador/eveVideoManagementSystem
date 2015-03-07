class OperationsController < ApplicationController
  def index
  end

  def create
    # Ships && Specialty Roles accept CSV and turns them into arrays
    params[:operation][:ships] = params[:operation][:ships].split(",")
    params[:operation][:specialty_roles] = params[:operation][:specialty_roles].split(",")

    @operation = Operation.create(create_params)

    redirect_to operation_path(@operation)
  end

  def new
    @dst = Time.now.dst?
    @operation = Operation.new()
  end

  def edit
  end

  def show
    @operation = Operation.find(params[:id])

    date_ordinal = @operation.op_date.strftime("%-d").to_i.ordinal
    @formatted_op_date = "#{@operation.op_date.strftime("%A the #{@operation.op_date.strftime("%-d")}#{date_ordinal} of %B")}"
  end

  def update
  end

  def destroy
  end

  private
    def create_params
      params.require(:operation).permit(:name, :op_date, :op_prep_start, :op_departure, :op_completion, :doctrine, :eve_time, :voice_coms_server, :voice_coms_server_channel, :rally_point, {specialty_roles: []}, {ships: []})
    end
end
