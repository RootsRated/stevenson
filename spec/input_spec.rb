require 'spec_helper'

module Stevenson::Input
  class Test
    include Base
  end
end

describe Stevenson::Input do
  let(:input) { double(:test_input) }
  let(:options) { Hash['type' => :test] }
  before { allow(Stevenson::Input::Test).to receive(:new).and_return(input) }

  describe ".input_for()" do
    context "when the input has been registered previously" do
      it "should return the input class from Stevenson.inputs" do
        expect(Stevenson::Input.input_for(options)).to eq(input)
      end
    end

    context "when the input has not been registered previously" do
      it "should return the fetched class from Stevenson" do
        allow(Stevenson).to receive(:inputs).and_return({})
        expect(Stevenson::Input.input_for(options)).to eq(input)
      end
    end

    context "when the input doesn't exist" do
      it "should raise a NameError with a descriptive error message" do
        expect { Stevenson::Input.input_for('type' => :bad_input) }.to raise_error do |error|
          expect(error).to be_a(NameError)
          expect(error.message).to eq("Type 'bad_input' is not a valid input type.")
          expect(error.cause).to be_a(NameError)
        end
      end
    end
  end
end
