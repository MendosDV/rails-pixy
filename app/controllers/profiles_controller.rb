class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update destroy]

  def index
    @profiles = current_user.profiles
    @visits = current_user.visits
    if params[:child].present?
      @profile = @profiles.find(params[:child])
    else
      @profile = current_user.profiles.find_by(selected: true)
    end
    # récupérer toutes les urls visités et mots changés pour l'ensemble des profils
    @today_profiles_visits = Visit.today.where(profile: @profiles)
    @today_words_changed = @today_profiles_visits.sum(&:words_changed)

    # pour les 7 derniers jours
    @last_seven_days_profiles_visits = Visit.week.where(profile: @profiles)
    @last_seven_days_words_changed = @last_seven_days_profiles_visits.sum(&:words_changed)


    # récupérer toutes les urls visités et mots changés pour un seul profil
    @today_profile_visits = @profile.visits.where("date >= ?", DateTime.current.beginning_of_day)
    @today_profile_words_changed = @today_profile_visits.sum(&:words_changed)

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
