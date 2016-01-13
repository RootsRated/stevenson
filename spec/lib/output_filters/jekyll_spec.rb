describe Stevenson::OutputFilter::Jekyll do
  let(:options) { {} }
  let(:temporary_directory) { '/tmp/directory' }
  let(:template) { double(:template, local_directory: temporary_directory) }
  let(:cocaine_line) { double(:cocaine_line, run: true) }
  before { allow(subject).to receive(:command).and_return(cocaine_line) }
  subject { described_class.new(template.local_directory, options) }

  describe '#output' do
    it "should build jekyll" do
      expect(cocaine_line).to receive(:run).with(hash_including(source: temporary_directory))
      subject.output
    end

    it 'outputs a jekyll compiled directory' do
      expect(subject.output).to eq File.join(temporary_directory, '_site')
    end
  end
end
