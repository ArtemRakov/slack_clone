class Web::Teams::ChannelsController < Web::Teams::ApplicationController
  def index
    @channels = user_channels
    @channels_to_discover = channels_to_discover
  end

  def show
    @channel = resource_team.find_channel(params[:id])
    @channels = resource_team.channels
    @messages = @channel.messages.as_json(include: :user)

    respond_to do |format|
      format.html
      format.json { render json: { channel: @channel, channels: @channels, messages: @messages, team: resource_team } }
    end
  end

  def new
    @channel = Team::Channel.new
  end

  def create
    @channel = resource_team.channels.build(channel_params)

    if @channel.save
      @channel.channel_invitations.create!(user: current_user)
      redirect_to team_channel_path(resource_team, @channel)
    else
      render :new
    end
  end

  private

  def channel_params
    params.require(:team_channel).permit(:name)
  end

  def user_channels
    current_user.channels.where(team: resource_team).where.not(name: Team::Channel::DEFAULT)
  end

  def channels_to_discover
    resource_team.channels.where.not(id: @channels).where.not(name: Team::Channel::DEFAULT)
  end
end
