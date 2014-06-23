class ActivitiesController < ActionController::Base
  layout "application"

  def index
    @activities = Activity.all
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new activity_params
    if @activity.save
      flash[:notice] = "Trip added"
      redirect_to activities_path
    else
      render :action => 'new'
    end
  end

  def edit
    @activity = Activity.find params[:id]
  end

  def update
    @activity = Activity.find params[:id]
    if @activity.update_attributes activity_params
      redirect_to activities_path
    else
      render :action => :edit
    end
  end

  def destroy
    @activity = Activity.find params[:id]
    @activity.destroy
    redirect_to activities_path
  end

  def show
    @activity = Activity.find params[:id]
  end



  private

  def activity_params
    params.require(:activity).permit(:arrival_date, :location)
  end




end