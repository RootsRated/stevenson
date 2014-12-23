describe Stevenson::Templates::GitTemplate do
  subject { Stevenson::Templates::GitTemplate }

  describe '#initialize' do
    context 'with a valid URL' do
      let(:git_template) { subject.new 'https://github.com/RootsRated/stevenson-base-template.git' }

      it 'creates a new GitTemplate' do
        expect(git_template).to be_an_instance_of Stevenson::Templates::GitTemplate
      end

      it 'clones the given repository to the working template path' do
        expect(File.exists? File.join(git_template.path, '_config.yml')).to eq true
      end
    end

    context 'with an invalid URL' do
      let(:invalid_url) {  'https://github.com/RootsRated/not-a-repo.git' }

      it 'raises an invalid template exception' do
        expect{ subject.new invalid_url }.to raise_exception(Stevenson::Templates::InvalidTemplateException)
      end
    end
  end
end
