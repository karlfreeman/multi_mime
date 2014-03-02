shared_examples_for 'an adapter' do |desired_adapter|

  around do |example|
    desired_constants = MultiMime::REQUIREMENT_MAP.select { |adapter, library, clazz| adapter != desired_adapter }.map { |adapter, library, clazz| clazz }
    undefine_constants(*desired_constants) { example.call }
    MultiMime.reset_adapter
  end

  describe :type_for do

    context :with_correct_mime_type do
      subject { MultiMime.type_for('text/html') }
      it { should eq 'text/html' }
    end

    context :with_incorrect_mime_type do
      subject { MultiMime.type_for('foo/bar') }
      it { should be_nil }
      it { should be_a MultiMime::NullType }
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
      it { should be_a MultiMime::NullType }
    end

  end

  describe :type_for_path do

    context :known_extension do
      subject { MultiMime.type_for_path('/usr/local/foo/bar.html') }
      it { should eq 'text/html' }
    end

    context :unknown_extension do
      subject { MultiMime.type_for_path('/usr/local/foo/bar.foo') }
      it { should be_nil }
      it { should be_a MultiMime::NullType }
    end

  end

  describe :type_for_file, fakefs: true do

    let(:extension_file) { File.open('foo.html', 'w') }
    let(:extensionless_file) { File.open('foo', 'w') }

    context :extension_file do
      subject { MultiMime.type_for_file(extension_file) }
      it { should eq 'text/html' }
    end

    context :extensionless_file do
      subject { MultiMime.type_for_file(extensionless_file) }
      it { should be_nil }
      it { should be_a MultiMime::NullType }
    end

  end

  describe :null_type do

    context :with_incorrect_mime_type do

      it 'should\'nt raise an exception when querying for formats' do
        mime = MultiMime.type_for('foo/bar')
        expect(mime).to be_nil
        expect(mime).to be_a MultiMime::NullType
        expect(mime.html?).to be false
        expect(mime.xml?).to be false
        expect(mime.json?).to be false
      end

    end

  end

end
