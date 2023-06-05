class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end

  def create
    @category = Category.find(params[:category_id])
    @profile = Profile.new(params_profile)
    @profile.category = @category
    @profile.user = current_user

    if @profile.save
      redirect_to profiles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.save
      redirect_to profiles_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def params_profile
    params.require(:profile).permit(:nickname, :birth_date)
  end
end
