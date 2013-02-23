shared_examples_for 'an adapter' do |adapter|

  before do
    begin
      MultiMime.use adapter
    rescue LoadError
      pending "Adapter #{adapter} couldn't be loaded (not installed?)"
    end
  end

  it 'works' do
    MultiMime.foo.should eq adapter
  end

end