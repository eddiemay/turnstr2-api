module Sortable
  extend ActiveSupport::Concern

  included do
    # Scopes
    scope :in_desc_order, -> { order id: :desc }
  end
end
