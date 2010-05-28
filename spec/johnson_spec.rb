require File.expand_path('../spec_helper', __FILE__)

describe 'Johnson' do
  def library; 'johnson' end
  def context_class; Johnson::Runtime end
  def error_class; Johnson::Error end
  it_should_behave_like "embedded javascript"
end
