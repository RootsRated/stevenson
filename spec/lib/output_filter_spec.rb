module Stevenson::OutputFilter
  class Test < Base
  end
end

describe Stevenson::OutputFilter do
  let(:filter) { Stevenson::OutputFilter::Test }

  describe ".generate!(template, options)" do
    let(:template) { double(:template) }
    let(:options) { Hash.new }
    let(:output) { double(:output) }
    let(:generator) { double(:generator, generate!: output) }
    subject { described_class.generate!(template, options) }

    it "should call Generator.new with options" do
      expect(Stevenson::OutputFilter::Generator).to receive(:new).with(options).and_return(generator)
      subject
    end

    it "should call generator's generate! with template" do
      allow(Stevenson::OutputFilter::Generator).to receive(:new).and_return(generator)
      expect(generator).to receive(:generate!).with(template)
      subject
    end

    it "should return generate!er's output response" do
      allow(Stevenson::OutputFilter::Generator).to receive(:new).and_return(generator)
      expect(subject).to eq output
    end
  end

  describe ".filter_for()" do
    context "when the filter has been registered previously" do
      it "should return the filter class from Stevenson.output_filters" do
        expect(Stevenson::OutputFilter.filter_for(:test)).to eq(filter)
      end
    end

    context "when the filter has not been registered previously" do
      it "should return the filter class from Stevenson.output_filters" do
        allow(Stevenson).to receive(:output_filters).and_return({})
        expect(Stevenson::OutputFilter.filter_for(:test)).to eq(filter)
      end
    end

    context "when the filter doesn't exist" do
      it "should raise a NameError with a descriptive error message" do
        expect { Stevenson::OutputFilter.filter_for(:bad_filter) }.to raise_error do |error|
          expect(error).to be_a(NameError)
          expect(error.message).to eq("Type 'bad_filter' is not a valid output type.")
          expect(error.cause).to be_a(NameError)
        end
      end
    end
  end
end
