require File.expand_path('../spec_helper', __FILE__)

describe 'Lyndon' do
  def library; 'lyndon' end
  def context_class; Lyndon::Runtime end
  def error_class; end
  it_should_behave_like "embedded javascript"
end
