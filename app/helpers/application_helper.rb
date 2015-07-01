module ApplicationHelper

  def tag_link_to sym,g
    atrb = GoalsController.actions[sym]
    atrb[:id] = g.id
    return link_to atrb[:label], {:id => atrb[:id], :workstream_id => g.workstream.id, :controller => atrb[:controller], :action => sym}, :remote => atrb[:remote], :method => atrb[:method]
  end

end
