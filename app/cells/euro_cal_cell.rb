class EuroCalCell < FrontendCell

  def sidebar
    @events = Event.nearest(limit=2)
    render
  end

end
