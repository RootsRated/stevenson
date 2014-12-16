describe Stevenson::Template::GitTemplate do
  subject { Stevenson::Template::GitTemplate }

  describe '#initialize' do
    let(:git_template) { subject.new 'https://github.com/RootsRated/stevenson-base-template.git' }

    it 'creates a new GitTemplate' do
      expect(git_template).to be_an_instance_of Stevenson::Template::GitTemplate
    end

    after { git_template.cleanup }
  end

  describe '#repository' do
    context 'with a valid URL' do
      let(:git_template) { subject.new 'https://github.com/RootsRated/stevenson-base-template.git' }

      it 'returns a Rugged Repo' do
        expect(git_template.repository).to be_an_instance_of Rugged::Repository
      end

      after { git_template.cleanup }
    end

    context 'with an invalid URL' do
      let(:git_template) { subject.new 'https://github.com/RootsRated/not-a-repo.git' }

      it 'returns false' do
        expect(git_template.repository).to eq false
      end

      after { git_template.cleanup }
    end
  end

  describe '#is_valid?' do
    context 'with a valid URL' do
      let(:git_template) { subject.new 'https://github.com/RootsRated/stevenson-base-template.git' }

      it 'returns true' do
        expect(git_template.is_valid?).to eq true
      end

      after { git_template.cleanup }
    end

    context 'with an invalid URL' do
      let(:git_template) { subject.new 'https://github.com/RootsRated/not-a-repo.git' }

      it 'returns false' do
        expect(git_template.is_valid?).to eq false
      end

      after { git_template.cleanup }
    end
  end

  describe '#path' do
    let(:git_template) { subject.new 'https://github.com/RootsRated/stevenson-base-template.git' }

    it 'returns the working directory of the repo' do
      expect(git_template.path).to eq git_template.repository.workdir
    end

    after { git_template.cleanup }
  end

  describe '#cleanup' do
    let(:git_template) { subject.new 'https://github.com/RootsRated/stevenson-base-template.git' }

    it 'returns the working directory of the repo' do
      tmpdir = git_template.repository.workdir
      git_template.cleanup
      expect(File.exists? tmpdir).to eq false
    end
  end
end
