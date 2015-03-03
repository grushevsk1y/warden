# encoding: UTF-8

require 'spec_helper'

describe Warden::Protocol::LimitMemoryRequest do
  subject(:request) do
    described_class.new(handle: 'handle')
  end

  it_should_behave_like 'wrappable request'

  it 'has a class type' do
    expect(request.class.type_camelized).to eq('LimitMemory')
    expect(request.class.type_underscored).to eq('limit_memory')
  end

  field :handle do
    it_should_be_required
    it_should_be_typed_as_string
  end

  field :limit_in_bytes do
    it_should_be_optional
    it_should_be_typed_as_uint64
  end

  it 'should respond to #create_response' do
    request.create_response.should be_a(Warden::Protocol::LimitMemoryResponse)
  end
end

describe Warden::Protocol::LimitMemoryResponse do
  subject(:response) do
    described_class.new
  end

  it_should_behave_like 'wrappable response'

  it 'has a class type' do
    expect(response.class.type_camelized).to eq('LimitMemory')
    expect(response.class.type_underscored).to eq('limit_memory')
  end

  it { should be_ok }
  it { should_not be_error }

  field :limit_in_bytes do
    it_should_be_optional
    it_should_be_typed_as_uint64
  end
end
