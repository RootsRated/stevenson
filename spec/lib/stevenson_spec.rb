describe Stevenson::Application do
  describe '#new' do
    context 'with a valid repo' do
      let(:directory_name) { Dir.mktmpdir }

      before do
        subject.options = { template: 'https://github.com/RootsRated/stevenson-base-template.git' }
        subject.new directory_name
      end

      it 'clones the repo to the given directory' do
        expect(Dir["#{directory_name}/*"].empty?).to eq false
      end

      after { FileUtils.remove_entry_secure directory_name }
    end

    context 'with an invalid repo' do
      let(:directory_name) { Dir.mktmpdir }
      let(:output) { capture(:stdout) { subject.new directory_name } }

      before do
        subject.options = { template: 'https://github.com/RootsRated/not-a-repo.git' }
      end

      it 'does not clone the repo to the given directory' do
        expect(Dir["#{directory_name}/*"].empty?).to eq true
      end

      it 'outputs an error message' do
        expect(output).to include 'No git repository could be found at the provided URL.'
      end

      after { FileUtils.remove_entry_secure directory_name }
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
