require File.expand_path('../spec_helper', __FILE__)

describe 'Rhino' do
  def library; 'rhino' end
  def context_class; Rhino::Context end
  def error_class; Rhino::JavascriptError end
  it_should_behave_like "embedded javascript"
end
