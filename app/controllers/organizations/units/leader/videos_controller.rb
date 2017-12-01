class Organizations::Units::Leader::VideosController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def index
    videos = @unit.videos

    locals ({
      videos: videos,
      unit_leader: current_user
    })
  end

  def create
    video = @unit.videos.build(video_params)

    if video.save
      flash[:success] = "Video Added!"
      redirect_to unit_leader_videos_path(@unit)
    else
      flash[:danger] = "There was a problem adding the video, please try again!"
      redirect_to unit_leader_videos_path(@unit)
    end
  end

  def destroy
    video = @unit.videos.find(params[:id])

    if @unit.videos.delete(video)
      flash[:success] = "Video Removed"
      redirect_to unit_leader_videos_path(@unit)
    else
      flash[:danger] = "There was a problem removing the video, please try again"
      redirect_to unit_leader_videos_path(@unit)
    end
  end

  private

  def video_params
    params.require(:video).permit(:name, :description, :page, :url)
  end
end
