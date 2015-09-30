describe Stevenson::Template::Local do
  let(:template_path) { '/path/to/local/template' }
  let(:options) { Hash.new }
  subject { described_class.new(template_path, options) }

  describe '#local_directory' do
    let(:tmp_dir) { '/tmp/dir/to/template' }
    before { allow(Dir).to receive(:mktmpdir).and_return(tmp_dir) }

    context 'when template_path is a valid path' do
      before { allow(File).to receive(:directory?).and_return(true) }

      it 'returns a temp directory' do
        allow(FileUtils).to receive(:cp_r).and_return(true)
        expect(subject.local_directory).to eq tmp_dir
      end

      it "copies the template_path's contents to the temp directory" do
        expect(FileUtils).to receive(:cp_r).with("#{template_path}/.", tmp_dir).and_return(true)
        expect(subject.local_directory).to eq tmp_dir
      end

      context "when the :subdirectory option is set" do
        let(:subdirectory) { 'subdirectory' }
        let(:options) { { subdirectory: subdirectory } }

        it "should copy the template_path's subdirectory" do
          expect(FileUtils).to receive(:cp_r).with("#{template_path}/#{subdirectory}/.", tmp_dir).and_return(true)
          subject.local_directory
        end
      end
    end

    context 'when template_path is an invalid path' do
      before { allow(File).to receive(:directory?).and_return(false) }

      it 'raises an invalid template exception' do
        expect { subject.local_directory }.to raise_exception(Stevenson::Template::InvalidTemplateException)
      end
    end
  end
end
