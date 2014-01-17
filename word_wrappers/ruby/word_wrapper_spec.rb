require 'rubygems'
require "rspec/autorun"

require './word_wrapper.rb'


describe String do
  describe "#wrap" do
    it "works on the example" do
      "The quick brown fox jumps over the lazy dog, but the dog totally deserved it.".wrap(40).should == "The quick brown fox jumps over the lazy\ndog, but the dog totally deserved it."
    end
  end
end
