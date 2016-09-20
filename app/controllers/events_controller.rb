class EventsController < FrontController
  def index
    @events = Event.nearest(limit=nil)
  end
end