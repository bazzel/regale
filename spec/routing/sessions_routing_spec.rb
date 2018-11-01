require 'rails_helper'

RSpec.describe 'routes for sessions', type: :routing do
  it { expect(get('sessions/new')).to route_to('sessions#new') }

  it { expect(get: signin_path).to route_to('sessions#new') }
end

