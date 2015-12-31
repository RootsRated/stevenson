describe Stevenson::OutputFilter::Generator do
  let(:options) { Hash.new }
  subject { described_class.new(options) }

  describe "#generate!(template)" do
    let(:template) { double(:template, local_directory: '/tmp/path/to/template') }
    let(:jekyll_output) { double(:jekyll_output) }
    let(:zip_output) { double(:zip_output) }
    before do
      allow_any_instance_of(Stevenson::OutputFilter::Jekyll).to receive(:output).and_return(jekyll_output)
    end

    it "should create a new filter for the jekyll filter's output" do
      expect(Stevenson::OutputFilter::Jekyll).to receive(:new).with(template.local_directory, options).and_call_original
      subject.generate!(template)
    end

    it "should return the filter's output result" do
      expect(subject.generate!(template)).to eq jekyll_output
    end

    context "when more than one filter exists" do
      let(:options) { { zip: "zip" } }
      let(:zip_filter) { double(:zip_filter, output: zip_output) }

      it "should build subsequent filters with the previous' output" do
        expect(Stevenson::OutputFilter::Zip).to receive(:new).with(jekyll_output, options).and_return(zip_filter)
        subject.generate!(template)
      end

      it "should return the subsequent filter's output" do
        allow(Stevenson::OutputFilter::Zip).to receive(:new).with(jekyll_output, options).and_return(zip_filter)
        expect(subject.generate!(template)).to eq zip_output
      end
    end
  end
end
