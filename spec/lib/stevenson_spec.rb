describe Stevenson::Application do
  context 'new' do
    context 'with an invalid repo' do
      let(:directory_name) { 'test_directory' }

      before do
        subject.options = { template: 'https://github.com/RootsRated/stevenson.git' }
      end

      it 'exits' do
        expect{
          subject.new directory_name
        }.to raise_exception SystemExit
      end
    end
  end
end
