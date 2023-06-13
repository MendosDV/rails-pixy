class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update destroy]

  def index
    @profiles = current_user.profiles
    @visits = current_user.visits

    @today_visits = Visit.where(date: Date.today)
    @last_seven_days_visits = Visit.where(date: (Date.today - 7.days)..Date.today)

    @words_changed += count

    @total_words_changed = @today_visits.sum(&:words_changed)
    @total_words_changed_last_seven_days = @last_seven_days_visits.sum(&:words_changed)
    #@total_words_changed_percentage = (@total_words_changed / @total_words_changed_last_seven_days) * 100
  end

  def show
  end

  def new
    @profile = Profile.new
  end

  def create
    @category = Category.find(params[:profile][:category_id])
    @profile = Profile.new(params_profile)
    @profile.user = current_user
    @profile.category = @category

    if @profile.save
      redirect_to profiles_path
    else
      render :new, status: :unprocessable_entity, flash: { error: @profile.errors.full_messages }
    end

  end

  def edit
  end

  def update
    @profile.update(params_profile)
    redirect_to profiles_path, notice: "Votre profil a bien été modifié"
  end

  def destroy
    @profile.destroy
    redirect_to profiles_path, notice: "Votre profil a bien été supprimé"
  end


  private

  def params_profile
    params.require(:profile).permit(:nickname, :birth_date, :picture, :category_id)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

end
