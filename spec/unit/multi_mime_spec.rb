require 'spec_helper'

describe MultiMime do

  context :validations do

    describe :type_for do
      specify { expect { MultiMime.type_for(nil) }.to raise_error(ArgumentError) }
    end

    describe :type_for_extension do
      specify { expect { MultiMime.type_for_extension(nil) }.to raise_error(ArgumentError) }
    end

    describe :type_for_path do
      specify { expect { MultiMime.type_for_path(nil) }.to raise_error(ArgumentError) }
    end

    describe :type_for_file do
      specify { expect { MultiMime.type_for_file(nil) }.to raise_error(ArgumentError) }
      specify { expect { MultiMime.type_for_file('.html') }.to raise_error(ArgumentError) }
    end

  end

  context :alias do

    describe :by_type do
      subject { MultiMime.instance_method(:by_type) }
      it { should == MultiMime.instance_method(:type_for) }
    end

    describe :by_extension do
      subject { MultiMime.instance_method(:by_extension) }
      it { should == MultiMime.instance_method(:type_for_extension) }
    end

    describe :by_path do
      subject { MultiMime.instance_method(:by_path) }
      it { should == MultiMime.instance_method(:type_for_path) }
    end

  end

  context :defaults do

    describe 'MIME::Types' do

      around do |example|
        undefine_constants(:MimeMagic, :Mime, :Rack) { example.call }
        MultiMime.reset_adapter
      end

      it 'should detect adapter' do
        require 'mime/types'
        expect(MultiMime.default_adapter).to eq :mime_types
      end

    end

    describe 'MimeMagic' do

      around do |example|
        undefine_constants(:MIME, :Mime, :Rack) { example.call }
        MultiMime.reset_adapter
      end

      it 'should detect adapter' do
        require 'mimemagic'
        expect(MultiMime.default_adapter).to eq :mimemagic
      end

    end

    describe 'Mime::Type' do

      around do |example|
        undefine_constants(:MIME, :MimeMagic, :Rack) { example.call }
        MultiMime.reset_adapter
      end

      it 'should detect adapter' do
        require 'action_dispatch/http/mime_type'
        expect(MultiMime.default_adapter).to eq :mime_type
      end

    end

    describe 'Rack::Mime' do

      around do |example|
        undefine_constants(:MIME, :Mime, :MimeMagic) { example.call }
        MultiMime.reset_adapter
      end

      it 'should detect adapter' do
        require 'rack/mime'
        expect(MultiMime.default_adapter).to eq :rack_mime
      end

    end

  end

  MultiMime::REQUIREMENT_MAP.each do |adapter, library, clazz|
    context adapter do
      it_behaves_like 'an adapter', adapter
    end
  end

end
