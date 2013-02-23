require 'spec_helper'

describe MultiMime do

  # context :defaults do

  #   describe 'MIME::Types' do

  #     it 'should detect adaptor' do
  #       Object.send(:remove_const, :MIME) if defined?(MIME)
  #       require 'mime/types'
  #       MultiMime.default_adapter.should eq :mime_types
  #     end

  #     after(:each) do
  #      Object.send(:remove_const, :MIME) if defined?(MIME)
  #     end

  #   end

  #   describe 'MimeMagic' do

  #     it 'should detect adaptor' do
  #       Object.send(:remove_const, :MimeMagic) if defined?(MimeMagic)
  #       require 'mimemagic'
  #       MultiMime.default_adapter.should eq :mimemagic
  #     end

  #     after(:each) do
  #      Object.send(:remove_const, :MimeMagic) if defined?(MimeMagic)
  #     end

  #   end
  
  #   describe 'Mime::Type' do

  #     it 'should detect adaptor' do
  #       Object.send(:remove_const, :Mime) if defined?(Mime)
  #       require 'action_dispatch/http/mime_type'
  #       MultiMime.default_adapter.should eq :mime_type
  #     end

  #     after(:each) do
  #      Object.send(:remove_const, :Mime) if defined?(Mime)
  #     end

  #   end

  #   describe 'Rack::Mime' do

  #     it 'should detect adaptor' do
  #       Object.send(:remove_const, :Rack) if defined?(Rack)
  #       require 'rack/mime'
  #       MultiMime.default_adapter.should eq :rack_mime
  #     end

  #     after(:each) do
  #      Object.send(:remove_const, :Rack) if defined?(Rack)
  #     end

  #   end

  # end

  %w(mime_types mimemagic mime_type rack_mime).each do |adapter|
    context adapter do
      it_behaves_like 'an adapter', adapter
    end
  end

end