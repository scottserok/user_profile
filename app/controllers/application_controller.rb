class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :ensure_profile!
  around_action :set_locale
  around_action :set_timezone

  protected

  def ensure_profile!
    return unless current_user
    return if current_user.profile
    redirect_to new_profile_path, notice: t('notice.complete_registration')
  end

  def set_locale(&block)
    locale = (params[:locale] || current_user&.profile&.locale || 'en')
    I18n.with_locale(locale, &block)
  rescue I18n::InvalidLocale
  end

  def set_timezone(&block)
    Time.use_zone((current_user&.profile&.timezone || 'UTC'), &block)
  end
end
