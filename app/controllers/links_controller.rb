class LinksController < ApplicationController
  before_action :require_user

  def index
    @links = current_user.links
  end

  def create
    @link = Link.new(link_params.merge({user: current_user}))
    if @link.save
      flash[:success] = "Added new link: #{@link.title}"
      redirect_to links_path
    else
      flash[:danger] = "Not valid link submission"
      redirect_to links_path
    end
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      flash[:success] = "Marked link #{@link.title} as read!"
      redirect_to links_path
    end
  end

  private
    def link_params
      params.require(:link).permit(:title, :url, :read)
    end
end
