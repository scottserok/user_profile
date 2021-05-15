class Profile < ApplicationRecord
  belongs_to :user

  enum locale: I18n.available_locales.map { |x| [x.to_s, x.to_s] }.to_h
  enum timezone: ActiveSupport::TimeZone.all.map { |x| [x.tzinfo.name, x.tzinfo.name] }.sort_by(&:first).to_h
end
