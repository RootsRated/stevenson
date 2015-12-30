describe Stevenson::OutputFilter::Zip do
  let(:temporary_directory) { '/tmp/directory' }
  let(:template) { double(:template, local_directory: temporary_directory) }
  subject { described_class.new(template.local_directory) }

  describe '#output' do
    let(:output_zip) { "#{temporary_directory}/#{File.basename(temporary_directory)}.zip" }

    it "should zip the files in temporary_directory to the zip" do
      expect(subject).to receive(:write).with(temporary_directory, output_zip).and_return(true)
      subject.output
    end

    it "should return the temporary_directory with '.zip' appended" do
      allow(subject).to receive(:write).and_return(true)
      expect(subject.output).to eq output_zip
    end
  end
end
