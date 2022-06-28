# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'dry/schema'

Dry::Rails.container do
  auto_register!('app/core')
end
