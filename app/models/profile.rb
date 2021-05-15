class Profile < ApplicationRecord
  belongs_to :user

  enum locale: I18n.available_locales.map { |x| [x, x] }.to_h
  enum timezone: ActiveSupport::TimeZone.all.map { |x| [x.tzinfo.name, x.tzinfo.name] }.to_h
end
