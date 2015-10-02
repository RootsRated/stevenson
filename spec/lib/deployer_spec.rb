class Stevenson::Deployer::Test
  include Stevenson::Deployer::Base
end

describe Stevenson::Deployer do
  let(:deployer) { Stevenson::Deployer::Test }

  describe ".deploy(directory, options)" do
    let(:directory) { "/tmp/path/to/template" }
    let(:options) { Hash.new }
    let(:deployer) { double(:deployer, deploy!: true) }
    subject { described_class.generate!(template, options) }
  end

  describe ".deployer_for()" do
    context "when the deployer has been registered previously" do
      it "should return the deployer class from Stevenson.deployers" do
        expect(Stevenson::Deployer.send(:deployer_for, :test)).to eq(deployer)
      end
    end

    context "when the deployer has not been registered previously" do
      it "should return the deployer class from Stevenson.deployers" do
        allow(Stevenson).to receive(:deployers).and_return({})
        expect(Stevenson::Deployer.send(:deployer_for, :test)).to eq(deployer)
      end
    end

    context "when the deployer doesn't exist" do
      it "should raise a NameError with a descriptive error message" do
        expect { Stevenson::Deployer.send(:deployer_for, :bad_deployer) }.to raise_error do |error|
          expect(error).to be_a(Stevenson::Deployer::InvalidDeployerException)
          expect(error.message).to eq("Type 'bad_deployer' is not a valid deployer.")
        end
      end
    end
  end
end
