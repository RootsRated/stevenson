require 'spec_helper'

module Stevenson::OutputFilter
  module Test
    include Base
  end
end

describe Stevenson::OutputFilter do
  let(:filter) { Stevenson::OutputFilter::Test }

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
