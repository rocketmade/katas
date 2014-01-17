require 'rubygems'
require "rspec/autorun"

require './first_letters.rb'

describe String do
  describe "#first_letters" do
    it "works on the example" do
      "The quick brown fox jumps over the lazy dog, but the dog totally deserved it.".first_letters.should == "Tqbfjotld btdtdi "
    end
  end
end
