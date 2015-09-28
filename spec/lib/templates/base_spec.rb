describe Stevenson::Templates::Base do
  subject { Stevenson::Templates::Base }

  describe '#initialize' do
    context 'with a valid path' do
      let(:path) { Dir.mktmpdir }

      before { FileUtils.touch File.join(path, '_stevenson.yml') }

      it 'creates a new Template' do
        expect( subject.new path ).to be_an_instance_of Stevenson::Templates::Base
      end

      after { FileUtils.remove_entry_secure path }
    end

    context 'with an invalid path' do
      let(:path) { Dir.mktmpdir }

      it 'raises an invalid template exception' do
        expect{ subject.new File.join(path, 'not-a-path') }.to raise_exception Stevenson::Templates::InvalidTemplateException
      end

      after { FileUtils.remove_entry_secure path }
    end
  end

  describe '#path' do
    let(:path) { Dir.mktmpdir }
    let(:template) { subject.new path }

    before do
      FileUtils.touch File.join(path, '_stevenson.yml')
    end

    it 'returns the path of the template' do
      expect(File.exists? File.join(template.path, '_stevenson.yml')).to eq true
    end

    after { FileUtils.remove_entry_secure path }
  end

  describe '#select_subdirectory' do
    let(:path) { Dir.mktmpdir }
    let(:subdirectory) { 'subdirectory' }
    let(:template) { subject.new path }

    before do
      Dir.mkdir File.join(path, subdirectory)
      FileUtils.touch File.join(path, subdirectory, '_stevenson.yml')
    end

    it 'changes the path of the template to a given subdirectory' do
      template.select_subdirectory subdirectory
      expect(File.exists? File.join(template.path, '_stevenson.yml')).to eq true
    end

    after do
      template.output path
      FileUtils.remove_entry_secure path
    end
  end

  describe '#output' do
    let(:path) { Dir.mktmpdir }
    let(:template) { subject.new path }
    let(:temporary_directory) { Dir.mktmpdir }

    before { template.output File.join(temporary_directory, 'output') }

    it 'outputs the finished template to the directory' do
      expect(File.exists? File.join(temporary_directory, 'output')).to eq true
    end

    it 'destroys the temporary directory' do
      expect(File.exists? template.path).to eq false
    end

    after do
      FileUtils.remove_entry_secure temporary_directory
    end
  end
end
