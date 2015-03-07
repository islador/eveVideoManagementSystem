class VideosController < ApplicationController
  before_action :authenticate_user!

  def show
    # Returns a given video's page
  end

  def index
    # Returns the mentioned table, with years populated
    # Clicking a year should retrieve the months
    # Clicking a month should retrieve the op
  end

  def new
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
    # Creates a video
  end

  def edit
    # Returns the video edit page
    # Video's should have owners, such that owners can edit the video
  end

  def update
    # Does the action of updating the target video
  end

  def destroy
    # Destroys the target
  end
end
