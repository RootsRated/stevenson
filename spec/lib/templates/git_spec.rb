describe Stevenson::Template::Git do
  let(:template_url) { 'http://www.github.com/Org/repo.git' }
  let(:options) { Hash.new }
  subject { described_class.new(template_url, options) }

  describe '#local_directory' do
    let(:tmp_dir) { '/tmp/dir/to/template' }
    let(:local_tmp_dir) { '/tmp/dir/to/local_template' }
    before { allow(Dir).to receive(:mktmpdir).and_return(tmp_dir, local_tmp_dir) }

    context 'when template_url is a valid URL' do
      let(:git_repo) { double(:git_repo) }
      before do
        allow(::Git).to receive(:clone).and_return(git_repo)
        allow(File).to receive(:directory?).with(tmp_dir).and_return(true)
        allow(FileUtils).to receive(:cp_r).with("#{tmp_dir}/.", local_tmp_dir).and_return(true)
      end

      it 'returns a temp directory' do
        expect(subject.local_directory).to eq local_tmp_dir
      end

      it 'clones the given repository to the working template path' do
        expect(::Git).to receive(:clone).with(template_url, tmp_dir)
        subject.local_directory
      end

      context "when the :branch option is set" do
        let(:branch) { 'test-branch' }
        let(:options) { { branch: branch } }

        it "should check out the related branch" do
          expect(git_repo).to receive(:checkout).with(branch).and_return(true)
          subject.local_directory
        end
      end
    end

    context 'when template_url is an invalid URL' do
      let(:template_url) {  'not/a/repo' }
      before { allow(::Git).to receive(:clone).and_raise(::Git::GitExecuteError) }

      it 'raises an invalid template exception' do
        expect { subject.local_directory }.to raise_exception(Stevenson::Template::InvalidTemplateException)
      end
    end
  end
end
