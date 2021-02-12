# frozen_string_literal: true

module Types
  class BookExtraInputType < BaseInputObject
    from_active_record BookExtra
  end
end
