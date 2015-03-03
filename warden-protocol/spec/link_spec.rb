# encoding: UTF-8

require 'spec_helper'

module Warden::Protocol
  describe LinkRequest do
    subject(:request) do
      described_class.new(handle: 'handle', job_id: 1)
    end

    it_should_behave_like 'wrappable request'

    it 'has a class type' do
      expect(request.class.type_camelized).to eq('Link')
      expect(request.class.type_underscored).to eq('link')
    end

    field :handle do
      it_should_be_required
      it_should_be_typed_as_string
    end

    field :job_id do
      it_should_be_required
      it_should_be_typed_as_uint
    end

    it 'should respond to #create_response' do
      request.create_response.should be_a(Warden::Protocol::LinkResponse)
    end
  end

  describe Warden::Protocol::LinkResponse do
    subject(:response) do
      described_class.new
    end

    it_should_behave_like 'wrappable response'

    it 'has a class type' do
      expect(response.class.type_camelized).to eq('Link')
      expect(response.class.type_underscored).to eq('link')
    end

    it { should be_ok }
    it { should_not be_error }

    field :exit_status do
      it_should_be_optional
      it_should_be_typed_as_uint
    end

    field :stdout do
      it_should_be_optional
      it_should_be_typed_as_string
    end

    field :stderr do
      it_should_be_optional
      it_should_be_typed_as_string
    end

    field :info do
      it_should_be_optional

      it 'should be a InfoResponse' do
        field.type.should == InfoResponse
      end
    end
  end
end
