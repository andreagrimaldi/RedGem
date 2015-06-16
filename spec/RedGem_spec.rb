require 'spec_helper'
require 'RedGem/number'

describe RedGem do
  it 'has a version number' do
    expect(RedGem::VERSION).not_to be nil
  end

  it 'does something useful' do
  	@number = Hello.new
  	@number.hello
  	@cc = Stamp::Number.thisisatest(2) 
    #expect(false).to eq(true)
    expect(false).to eq(true)
  end
end
