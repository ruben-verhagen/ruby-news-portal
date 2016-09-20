class Admin::EventsController < AdminController
  def index
    @events = Event.paginate(paginate_params)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:success] = 'Event was successfully created'

      redirect_to admin_events_path
    else
      flash[:error] = "Can't create a event. Checkout the errors below"
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(event_params)
      flash[:success] = 'Event was successfully updated'

      redirect_to admin_events_path
    else
      flash[:error] = 'Please checkout the event updating errors'
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy if @event.present?

    redirect_to admin_events_path, flash: { success: 'Event was successfully destroyed' }
  end

  protected

  def event_params
    params.require(:event).permit(:happens_at, :title, :description, :in_ticker)
  end
end