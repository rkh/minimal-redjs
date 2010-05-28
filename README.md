This rather experiments what API subset different embedded JavaScript engines have in common than being a spec.

    libs = {
      'johnson' => proc { Johnson::Runtime }, # 'lyndon' => proc { Lyndon::Runtime },
      'v8'      => proc { V8::Context },      'rhino'  => proc { Rhino::Context }
    }
    
    lib, runtime = libs.detect do |path, block|
      begin
        require path
        true
      rescue LoadError
        false
      end
    end
    
    fail "no lib found" unless lib
    js = runtime.call.new
    
    js.load "my_file.js"
    
    js.evaluate "x = 10"
    js[:x] + 20 # => 30
    
    js[:x] = 42
    js.evaluate "x - 19" # => 23
    
    block = js.evaluate "(function(val) { return val + 2; })"
    block.call js[:x] # => 42
