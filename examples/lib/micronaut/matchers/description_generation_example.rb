require File.expand_path(File.dirname(__FILE__) + "/../../../example_helper")

describe Micronaut::Matchers do

  describe "should be able to generate their own descriptions" do
    
    after do
      Micronaut::Matchers.clear_generated_description
    end

    it "should == expected" do
      "this".should == "this"
      Micronaut::Matchers.generated_description.should == "should == \"this\""
    end

    it "should not == expected" do
      "this".should_not == "that"
      Micronaut::Matchers.generated_description.should == "should not == \"that\""
    end

    it "should be empty (arbitrary predicate)" do
      [].should be_empty
      Micronaut::Matchers.generated_description.should == "should be empty"
    end

    it "should not be empty (arbitrary predicate)" do
      [1].should_not be_empty
      Micronaut::Matchers.generated_description.should == "should not be empty"
    end

    it "should be true" do
      true.should be_true
      Micronaut::Matchers.generated_description.should == "should be true"
    end

    it "should be false" do
      false.should be_false
      Micronaut::Matchers.generated_description.should == "should be false"
    end

    it "should be nil" do
      nil.should be_nil
      Micronaut::Matchers.generated_description.should == "should be nil"
    end

    it "should be > n" do
      5.should be > 3
      Micronaut::Matchers.generated_description.should == "should be > 3"
    end

    it "should be predicate arg1, arg2 and arg3" do
      5.0.should be_between(0,10)
      Micronaut::Matchers.generated_description.should == "should be between 0 and 10"
    end

    it "should be_few_words predicate should be transformed to 'be few words'" do
      5.should be_kind_of(Fixnum)
      Micronaut::Matchers.generated_description.should == "should be kind of Fixnum"
    end

    it "should preserve a proper prefix for be predicate" do
      5.should be_a_kind_of(Fixnum)
      Micronaut::Matchers.generated_description.should == "should be a kind of Fixnum"
      5.should be_an_instance_of(Fixnum)
      Micronaut::Matchers.generated_description.should == "should be an instance of Fixnum"
    end

    it "should equal" do
      expected = "expected"
      expected.should equal(expected)
      Micronaut::Matchers.generated_description.should == "should equal \"expected\""
    end

    it "should_not equal" do
      5.should_not equal(37)
      Micronaut::Matchers.generated_description.should == "should not equal 37"
    end

    it "should eql" do
      "string".should eql("string")
      Micronaut::Matchers.generated_description.should == "should eql \"string\""
    end

    it "should not eql" do
      "a".should_not eql(:a)
      Micronaut::Matchers.generated_description.should == "should not eql :a"
    end

    it "should have_key" do
      {:a => "a"}.should have_key(:a)
      Micronaut::Matchers.generated_description.should == "should have key :a"
    end

    it "should have n items" do
      team.should have(3).players
      Micronaut::Matchers.generated_description.should == "should have 3 players"
    end

    it "should have at least n items" do
      team.should have_at_least(2).players
      Micronaut::Matchers.generated_description.should == "should have at least 2 players"
    end

    it "should have at most n items" do
      team.should have_at_most(4).players
      Micronaut::Matchers.generated_description.should == "should have at most 4 players"
    end

    it "should include" do
      [1,2,3].should include(3)
      Micronaut::Matchers.generated_description.should == "should include 3"
    end

    it "should match" do
      "this string".should match(/this string/)
      Micronaut::Matchers.generated_description.should == "should match /this string/"
    end

    it "should raise_error" do
      lambda { raise }.should raise_error
      Micronaut::Matchers.generated_description.should == "should raise Exception"
    end

    it "should raise_error with type" do
      lambda { raise }.should raise_error(RuntimeError)
      Micronaut::Matchers.generated_description.should == "should raise RuntimeError"
    end

    it "should raise_error with type and message" do
      lambda { raise "there was an error" }.should raise_error(RuntimeError, "there was an error")
      Micronaut::Matchers.generated_description.should == "should raise RuntimeError with \"there was an error\""
    end

    it "should respond_to" do
      [].should respond_to(:insert)
      Micronaut::Matchers.generated_description.should == "should respond to [:insert]"
    end

    it "should throw symbol" do
      lambda { throw :what_a_mess }.should throw_symbol
      Micronaut::Matchers.generated_description.should == "should throw a Symbol"
    end

    it "should throw symbol (with named symbol)" do
      lambda { throw :what_a_mess }.should throw_symbol(:what_a_mess)
      Micronaut::Matchers.generated_description.should == "should throw :what_a_mess"
    end

    def team
      Class.new do
        def players
          [1,2,3]
        end
      end.new
    end
    
  end

  describe "a matcher with no description" do
    
    def matcher
      Class.new do
        def matches?(ignore); true; end
        def failure_message; ""; end
      end.new
    end

    it "should provide a helpful message when used in a string-less example block" do
      5.should matcher
      Micronaut::Matchers.generated_description.should =~ /When you call.*description method/m
    end
    
  end

end