module LinksHelper
  def change_status_text(status)
    "Mark as Unread" if status
    "Mark as Read"
  end

  def status(status)
    "read" if status
    "unread"
  end

end
