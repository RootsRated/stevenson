describe Stevenson::Application do
  describe '#new' do
    context 'with a valid repo' do
      let(:directory_name) { Dir.mktmpdir }
      let(:output) { capture(:stdout) { subject.new directory_name } }

      it 'creates a directory at test_directory' do
        expect(File.exists? directory_name).to eq true
      end

      after { FileUtils.remove_entry_secure directory_name }
    end

    context 'with an invalid repo' do
      let(:directory_name) { 'test_directory' }
      let(:output) { capture(:stdout) { subject.new directory_name } }

      before do
        subject.options = { template: 'https://github.com/RootsRated/not-a-repo.git' }
      end

      it 'does not create a directory at test_directory' do
        expect(File.exists? directory_name).to eq false
      end

      it 'outputs an error message' do
        expect(output).to include 'No git repository could be found at the provided URL.'
      end
    end
  end

  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end
  
    result
  end
end
