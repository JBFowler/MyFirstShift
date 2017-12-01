class Organizations::Owner::VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    videos = @organization.videos

    locals ({
      videos: videos,
      owner: current_user
    })
  end

  def create
    video = @organization.videos.build(video_params)

    if video.save
      if @organization.units.any?
        @organization.units.each do |unit|
          unit.videos.build(video_params)
          unit.save
        end
      end

      flash[:success] = "Video Added!"
      redirect_to owner_videos_path
    else
      flash[:danger] = "There was a problem adding the video, please try again!"
      redirect_to owner_videos_path
    end
  end

  def destroy
    video = @organization.videos.find(params[:id])

    if video.delete
      flash[:success] = "Video Removed"
      redirect_to owner_videos_path
    else
      flash[:danger] = "There was a problem removing the video, please try again"
      redirect_to owner_videos_path
    end
  end

  private

  def video_params
    params.require(:video).permit(:name, :description, :page, :url)
  end
end
