class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :ensure_profile!

  protected

  def ensure_profile!
    return if current_user.profile
    redirect_to new_profile_path, notice: t('notice.complete_registration')
  end
end
