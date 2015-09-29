describe Stevenson::Template::Loader do
  let(:template_name) { 'template' }
  let(:options) { Hash.new }
  subject { described_class.new(template_name, options) }

  describe "#template" do
    context "when 'template_name' matches an alias" do
      let(:aliased_template) do
        double(:aliased_template, name: 'template_path', options: {})
      end
      let(:dotfile) do
        double(:dotfile, template_aliases: { template_name => aliased_template })
      end

      before { allow(Stevenson).to receive(:dotfile).and_return(dotfile) }

      it "should call Loader on Template with the name" do
        expect(Stevenson::Template).to receive(:load).with(aliased_template.name, aliased_template.options)
        subject.template
      end
    end

    context "when 'template' matches a git repo" do
      let(:template_name) { 'http://www.github.com/Org/repo.git' }

      it "should return a Git template" do
        expect(subject.template).to be_a Stevenson::Template::Git
      end
    end

    it "should return a Local template " do
      expect(subject.template).to be_a Stevenson::Template::Local
    end
  end
end
