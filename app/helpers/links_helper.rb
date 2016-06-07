module LinksHelper
  def change_status_text(status)
    return "Mark as Unread" if status
    "Mark as Read"
  end
end
