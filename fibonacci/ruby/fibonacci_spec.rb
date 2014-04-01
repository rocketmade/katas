require 'rubygems'
require "rspec/autorun"

require './fibonacci.rb'

describe Integer do
  describe "#fibonacci" do
    it "0 => 0" do
      0.fibonacci.should == 0
    end
    it "1 => 1" do
      1.fibonacci.should == 1
    end
    it "2 => 1" do
      2.fibonacci.should == 1
    end
    it "3 => 2" do
      3.fibonacci.should == 2
    end
    it "4 => 3" do
      4.fibonacci.should == 3
    end
    it "5 => 5" do
      5.fibonacci.should == 5
    end
    it "6 => 8" do
      6.fibonacci.should == 8
    end
    it "7 => 13" do
      7.fibonacci.should == 13
    end
    it "100 => 354224848179261915075" do
      100.fibonacci.should == 354224848179261915075
    end

    it "1000 => 43466557686937456435688527675040625802564660517371780402481729089536555417949051890403879840079255169295922593080322634775209689623239873322471161642996440906533187938298969649928516003704476137795166849228875" do
      1000.fibonacci.should == 43466557686937456435688527675040625802564660517371780402481729089536555417949051890403879840079255169295922593080322634775209689623239873322471161642996440906533187938298969649928516003704476137795166849228875
    end
  end
end
