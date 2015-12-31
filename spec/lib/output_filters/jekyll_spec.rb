describe Stevenson::OutputFilter::Jekyll do
  let(:options) { {} }
  let(:temporary_directory) { '/tmp/directory' }
  let(:template) { double(:template, local_directory: temporary_directory) }
  subject { described_class.new(template.local_directory, options) }

  describe '#output' do
    it "should change into the template's directory" do
      expect(Dir).to receive(:chdir).with(temporary_directory)
      subject.output
    end

    it "should build jekyll" do
      allow(Dir).to receive(:chdir).with(temporary_directory).and_yield
      expect(subject).to receive(:`).with("jekyll b")
      subject.output
    end

    it 'outputs a jekyll compiled directory' do
      allow(Dir).to receive(:chdir).with(temporary_directory)
      expect(subject.output).to eq File.join(temporary_directory, '_site')
    end
  end
end
