class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update destroy]

  def index
    @profiles = Profile.all
  end

  def change_category
    @profile = Profile.find(params[:id])
    @category = Category.find(params[:category_id])

    if @profile.update(category: @category)
      render json: { success: true }
    else
      render json: { success: false, error: 'Failed to update category' }
    end
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
    params.require(:profile).permit(:nickname, :birth_date, :picture, :categoy_id)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

end
