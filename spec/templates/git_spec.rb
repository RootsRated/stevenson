describe Stevenson::Templates::GitTemplate do
  subject { Stevenson::Templates::GitTemplate }

  describe '#initialize' do
    context 'with a valid URL' do
      let(:template) { subject.new 'https://github.com/RootsRated/stevenson-base-template.git' }

      it 'creates a new GitTemplate' do
        expect(template).to be_an_instance_of Stevenson::Templates::GitTemplate
      end

      it 'clones the given repository to the working template path' do
        expect(File.exists? File.join(template.path, 'base', '_config.yml')).to eq true
      end
    end

    context 'with an invalid URL' do
      let(:invalid_url) {  'https://github.com/RootsRated/not-a-repo.git' }

      it 'raises an invalid template exception' do
        expect{ subject.new invalid_url }.to raise_exception(Stevenson::Templates::InvalidTemplateException)
      end
    end
  end

  describe '#switch_branch' do
    let(:branch) { 'master' }
    let(:template) { subject.new 'https://github.com/RootsRated/stevenson-base-template.git' }

    before { template.switch_branch branch }

    it 'checksout the repo to the given branch' do
      repo = Git::Base.open(template.path)
      expect(repo.current_branch).to eq branch
    end
  end
end
