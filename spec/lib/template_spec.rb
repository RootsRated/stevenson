describe Stevenson::Template do
  let(:template_name) { 'template' }
  let(:options) { Hash.new }

  describe ".load(template, options)" do
    let(:template) { double(:template) }
    let(:loader) { double(:loader, template: template) }
    subject { described_class.load(template_name, options) }

    it "should call Loader.new with template_name and options" do
      expect(Stevenson::Template::Loader).to receive(:new).with(template_name, options).and_return(loader)
      subject
    end

    it "should return Loader's template response" do
      allow(Stevenson::Template::Loader).to receive(:new).and_return(loader)
      expect(subject).to eq template
    end
  end
end
