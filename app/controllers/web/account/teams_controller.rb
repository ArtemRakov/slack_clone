class Web::Account::TeamsController < Web::Account::ApplicationController
  def index
    @teams = current_user.owned_teams
  end

  def new
    @team = Team.new
  end

  def create
    @team = current_user.owned_teams.build(team_params)

    if @team.save
      @team.invitations.create!(user: current_user)
      @team.channels.create(name: Team::Channel::DEFAULT)

      redirect_to account_teams_path
    else
      render :new
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :description)
  end
end
