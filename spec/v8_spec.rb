require File.expand_path('../spec_helper', __FILE__)

describe 'V8' do
  def library; 'v8' end
  def context_class; V8::Context end
  def error_class; V8::JavascriptError end
  it_should_behave_like "embedded javascript"
end
