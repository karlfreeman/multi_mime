require "spec_helper"

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
      specify { expect { MultiMime.type_for_file(".html") }.to raise_error(ArgumentError) }
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

  # context :defaults do

  #   before do
  #     Object.send(:remove_const, :MIME) if defined?(::MIME::Types)
  #     Object.send(:remove_const, :MimeMagic) if defined?(::MimeMagic)
  #     Object.send(:remove_const, :Mime) if defined?(::Mime::Type)
  #     Object.send(:remove_const, :Rack) if defined?(::Rack::Mime)
  #     MultiMime.reset_adapter
  #   end

  #   after do
  #     Object.send(:remove_const, :MIME) if defined?(::MIME::Types)
  #     Object.send(:remove_const, :MimeMagic) if defined?(::MimeMagic)
  #     Object.send(:remove_const, :Mime) if defined?(::Mime::Type)
  #     Object.send(:remove_const, :Rack) if defined?(::Rack::Mime)
  #     MultiMime.reset_adapter
  #   end

  #   describe "MIME::Types" do

  #     it "should detect adaptor" do
  #       require "mime/types"
  #       expect(MultiMime.default_adapter).to eq :mime_types
  #     end

  #   end

  #   describe "MimeMagic" do

  #     it "should detect adaptor" do
  #       require "mimemagic"
  #       expect(MultiMime.default_adapter).to eq :mimemagic
  #     end

  #   end

  #   describe "Mime::Type" do

  #     it "should detect adaptor" do
  #       require "action_dispatch/http/mime_type"
  #       expect(MultiMime.default_adapter).to eq :mime_type
  #     end

  #   end

  #   describe "Rack::Mime" do

  #     it "should detect adaptor" do
  #       require "rack/mime"
  #       expect(MultiMime.default_adapter).to eq :rack_mime
  #     end

  #   end

  # end

  %w(mime_types mimemagic mime_type rack_mime).each do |adapter|
    context adapter do
      it_behaves_like "an adapter", adapter
    end
  end

end