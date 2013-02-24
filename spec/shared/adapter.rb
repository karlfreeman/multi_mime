shared_examples_for 'an adapter' do |adapter|

  before do
    begin
      MultiMime.use adapter
    rescue LoadError
      pending "Adapter #{adapter} couldn't be loaded (not installed?)"
    end
  end

  describe :type_for_extension do

    context :without_dot do
      subject { MultiMime.type_for_extension('html') }
      it { should eq 'text/html' }
    end

    context :with_dot do
      subject { MultiMime.type_for_extension('.html') }
      it { should eq 'text/html' }
    end

    context :unknown_extension do
      subject { MultiMime.type_for_extension('.foo.bar') }
      it { should be_nil }
    end

  end

  describe :type_for do

    context :with_correct_mime_type do
      subject { MultiMime.type_for('text/html') }
      it { should eq 'text/html' }
    end

    context :with_incorrect_mime_type do
      subject { MultiMime.type_for('foo/bar') }
      it { should be_nil }
    end

  end

end