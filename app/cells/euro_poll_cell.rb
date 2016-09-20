class EuroPollCell < FrontendCell
  helper ApplicationHelper

  def sidebar
    @graph = Graph.find_by(code: :euro_poll)

    render
  end

  def main
    render
  end

end
