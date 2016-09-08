require 'rails_helper'

describe Restaurant do
  it 'returns name when to_s is called' do
    r = Restaurant.new(name: "SomeName")
    expect("#{r}").to eq "SomeName"
  end
end
