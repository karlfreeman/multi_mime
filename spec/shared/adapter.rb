shared_examples_for 'an adapter' do |adapter|

  before do
    begin
      MultiMime.use adapter
    rescue LoadError
      pending "Adapter #{adapter} couldn't be loaded (not installed?)"
    end
  end

  context :by_extension do

    describe :without_dot do
      subject { MultiMime.by_extension('html') }
      it { should eq 'text/html' }
    end

    describe :with_dot do
      subject { MultiMime.by_extension('.html') }
      it { should eq 'text/html' }
    end

    describe :unknown_extension do
      subject { MultiMime.by_extension('.foo.bar') }
      it { should be_nil }
    end

  end

end