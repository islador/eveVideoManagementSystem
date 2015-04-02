class VideosController < ApplicationController
  before_action :authenticate_user!

  def latest
    # Retrieve the 20 latest videos
    @videos = Video.last(20)

    # Assemble an easy to access hash of the operation's names.
    op_ids = Video.pluck("operation_id").last(20)
    operation_names = Operation.where(id: op_ids).pluck("name", "id")
    @names = {}
    operation_names.each do |name|
      @names.store(name[1], name[0])
    end
  end

  def show
    authorize self
    # Returns a given video's page
    @video = Video.find(params[:id])
  end

  def index
    authorize self
    today = Date.today
    first_date = Operation.first.op_date

    @years = []
    (today.year - first_date.year).times do |t|
      @years.push(first_date.year + t)
    end
    @years.push(today.year)

    @months = []
    puts today.strftime("%B")
    today.month.times do |t|
      @months.push(today.prev_month(t).strftime("%B"))
    end


    @operations = Operation.where(op_date: today.beginning_of_month..today.end_of_month)
    # Returns the mentioned table, with years populated
    # Clicking a year should retrieve the months
    # Clicking a month should retrieve the op
  end

  def new
    authorize self
    @video = Video.new()

    @kind_options = [["Raw", "raw"],["Edited", "edited"]]
    @operation_id_options = []

    operations = Operation.last(10).reverse
    no_operation = Operation.find_by(name: "No Operation")
    operations.each do |operation|
      unless operation.name == "No Operation"
        option = ["#{operation.name}", "#{operation.id}"]
        @operation_id_options.push(option)
      end
    end
    @operation_id_options.push(["#{no_operation.name}", "#{no_operation.id}"])
  end

  def create
    authorize self
    #Has no error handling
    video = Operation.find(params[:video][:operation_id]).videos.create(create_video_params)

    redirect_to video_path(video)
  end

  def edit
    authorize self
    # Returns the video edit page
    # Video's should have owners, such that owners can edit the video
  end

  def update
    authorize self
    # Does the action of updating the target video
  end

  def destroy
    authorize self
    # Destroys the target
  end

  private
    def create_video_params
      params.require(:video).permit(:name, :filmed_on, :operation_id, :s3_url, :kind)
    end
end
