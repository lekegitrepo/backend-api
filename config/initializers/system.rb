# frozen_string_literal: true

Dry::Rails.container do
  auto_register!('app/core')
end
