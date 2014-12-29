describe Stevenson::OutputFilters::JekyllFilter do
  describe '#output' do
    let(:temporary_directory) { Dir.mktmpdir }
    let(:template) { Stevenson::TemplateLoader.load 'hyde' }

    before do
      template.extend(subject)
      template.output temporary_directory
    end

    it 'outputs a jekyll compiled directory' do
      expect(File.exists? File.join(temporary_directory, '_config.yml')).to eq false
    end

    after { FileUtils.remove_entry_secure temporary_directory }
  end
end
