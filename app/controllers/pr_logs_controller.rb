class PrLogsController < ApplicationController
  before_action :set_pr_log, only: [:show]
  skip_before_action :verify_authenticity_token, only: [:create]
  # skip_before_action :authenticate_user!, :require_no_authentication, :check_user_confirmation, :check_user_approved, :check_user_locked, :check_user_timeout, :check_user_allow_remember_me, :check_user_not_expired, :check_user_not_disabled, :check_user_not_inactive, :check_user_not_pending, :check_user_not_disabled, :check_user_not_remember_across_sessions, :check_user_not_timedout, :check_user_not_deactivated, :check_user_not_remember_across_sessions, :check_user_not_remember_me_timeout, :check_user_not_secured, :check_user_unconfirmed, :check_user_unlocked, :check_user_unsubscribed, only: [:create]



  # GET /pr_logs or /pr_logs.json
  def index
    @pr_logs = PrLog.all
  end

  # GET /pr_logs/1 or /pr_logs/1.json
  def show
  end

  # POST /pr_logs or /pr_logs.json
  def create
    payload = JSON.parse(params[:payload])

    if payload["action"] == "closed"
      @pr_log = build_pr_log_from_payload(payload)
      @pr_log.save
    end

    respond_to do |format|
      if @pr_log.save 
        format.html { redirect_to pr_log_url(@pr_log), notice: "Pr log was successfully created." }
        format.json { render :show, status: :created, location: @pr_log }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pr_log.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pr_log
      @pr_log = PrLog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pr_log_params
      params.require(:pr_log).permit(:title, :state, :merged_at, :created_at, :pr_username, :user_avatar, :user_profile_link, :merged_by, :merged_user_avatar)
    end

    # Build a new PrLog instance from payload
    def build_pr_log_from_payload(payload)
      PrLog.new(
        title: payload["pull_request"]["title"],
        state: payload["pull_request"]["state"],
        merged_at: payload["pull_request"]["merged_at"],
        created_time: payload["pull_request"]["created_at"],
        pr_username: payload["pull_request"]["user"]["login"],
        user_avatar: payload["pull_request"]["user"]["avatar_url"],
        user_profile_link: payload["pull_request"]["user"]["url"],
        merged_by: payload["pull_request"]["merged_by"]["login"],
        merged_user_avatar: payload["pull_request"]["merged_by"]["avatar_url"]
      )
    end
end
