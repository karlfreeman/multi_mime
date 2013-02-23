require 'spec_helper'

describe MultiMime do

  # context :defaults do

  #   after(:each) do
  #     Object.send(:remove_const, :MIME) if defined?(::MIME::Types)
  #     Object.send(:remove_const, :MimeMagic) if defined?(::MimeMagic)
  #     Object.send(:remove_const, :Mime) if defined?(::Mime::Type)
  #     Object.send(:remove_const, :Rack) if defined?(::Rack::Mime)
  #   end

  #   before(:each) do
  #     Object.send(:remove_const, :MIME) if defined?(::MIME::Types)
  #     Object.send(:remove_const, :MimeMagic) if defined?(::MimeMagic)
  #     Object.send(:remove_const, :Mime) if defined?(::Mime::Type)
  #     Object.send(:remove_const, :Rack) if defined?(::Rack::Mime)
  #   end

  #   describe 'MIME::Types' do

  #     it 'should detect adaptor' do
  #       require 'mime/types'
  #       MultiMime.default_adapter.should eq :mime_types
  #     end

  #   end

  #   describe 'MimeMagic' do

  #     it 'should detect adaptor' do
  #       require 'mimemagic'
  #       MultiMime.default_adapter.should eq :mimemagic
  #     end

  #   end
  
  #   describe 'Mime::Type' do

  #     it 'should detect adaptor' do
  #       require 'action_dispatch/http/mime_type'
  #       MultiMime.default_adapter.should eq :mime_type
  #     end

  #   end

  #   describe 'Rack::Mime' do

  #     it 'should detect adaptor' do
  #       require 'rack/mime'
  #       MultiMime.default_adapter.should eq :rack_mime
  #     end

  #   end

  # end

  %w(mime_types mimemagic mime_type rack_mime).each do |adapter|
    context adapter do
      it_behaves_like 'an adapter', adapter
    end
  end

end