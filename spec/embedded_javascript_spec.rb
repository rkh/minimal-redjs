require File.expand_path('../spec_helper', __FILE__)

shared_examples_for "embedded javascript" do
  before do
    begin
      require library
    rescue LoadError
      pending "not installed"
    end
    @context = context_class.new
  end

  describe :evaluate do
    statements = %w[true false 42 1.5 1+1]
    statements << "true ? 10 : 20" << "x = 10; x"
    statements << '"foo"' << "'bar'"

    statements.each do |statement|
      it "should convert #{statement}" do
        @context.evaluate(statement).should == eval(statement)
      end
    end

    it "returns a javascript function's return value" do
      @context.evaluate("(function() { return 42; })()").should == 42
    end

    it "wraps and javascript objects" do
      object = @context.evaluate("({foo: 'bar', baz: 'bang', '5': 5, embedded: {badda: 'bing'}})")
      object.should_not be_nil        
      object['foo'].should == 'bar'
      object['baz'].should == 'bang'
      object['5'].should == 5
      object['embedded'].tap do |embedded|  
        embedded.should_not be_nil
        embedded['badda'].should == 'bing'
      end
    end

    it "converts js Date to ruby Time or Date" do
      value = @context.evaluate "new Date()"
      (value.is_a? Time or value.is_a? Date).should be_true
    end

    it "wraps functions in proc-like objects" do
      value = @context.evaluate("(function() { return 42 })")
      value.should respond_to(:call)
      # FIXME: therubyracer requires an argument to be passed
      value.call({}).should == 42
    end
  end

  describe :[] do
    it "converts ruby Time to js Date" do
      @context[:value] = Time.now
      @context.evaluate("value instanceof Date").should be_true
    end

    it "allowes setting javascript vars from ruby" do
      @context[:foo] = 42
      @context.evaluate("foo").should == 42
    end

    it "allowes accessing javascript vars" do
      @context.evaluate "x = 10"
      @context[:x].should == 10
    end

    it "maps procs to functions" do
      @context[:foo] = lambda { 42 }
      @context.evaluate("foo()").should == 42
    end

    it "wraps any ruby objects" do
      obj = Object.new
      @context[:foo] = obj
      @context.evaluate("foo").should == obj
    end
  end

  describe :load do
  end
end