describe Stevenson::Template::GitTemplate do
  subject { Stevenson::Template::GitTemplate }

  describe '#initialize' do
    context 'with a valid URL' do
      let(:git_template) { subject.new 'https://github.com/RootsRated/stevenson-base-template.git' }

      it 'assigns repo with a Rugged Repo' do
        expect(git_template.repository).to be_an_instance_of Rugged::Repository
      end
    end

    context 'with an invalid URL' do
      let(:git_template) { subject.new 'https://github.com/RootsRated/not-a-repo.git' }

      it 'assigns repo with a Rugged Repo' do
        expect(git_template.repository).to eq false
      end
    end
  end

  describe 'is_valid?' do
  end

  describe 'path' do
  end

  describe 'cleanup' do
  end
end
