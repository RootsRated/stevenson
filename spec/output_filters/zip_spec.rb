describe Stevenson::OutputFilters::ZipFilter do
  describe '#output' do
    let(:temporary_directory) { Dir.mktmpdir }
    let(:template) { Stevenson::Template::GitTemplate.new 'https://github.com/RootsRated/stevenson-base-template.git' }

    before do
      template.extend(subject)
      template.output File.join(temporary_directory, 'archive.zip')
    end

    it 'outputs a zipped directory' do
      expect(File.exists? File.join(temporary_directory, 'archive.zip')).to eq true
    end

    after { FileUtils.remove_entry_secure temporary_directory }
  end
end
