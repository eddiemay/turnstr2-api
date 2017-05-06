module HasGender
  extend ActiveSupport::Concern

  included do
    enumerize :gender, in: %w(male female)
  end
end