describe Stevenson::TemplateLoader do
  subject { Stevenson::TemplateLoader }

  describe '.load' do
    context 'when given a template alias' do
      let(:template_alias) { 'hyde' }
      let(:template) { subject.load template_alias }

      it 'returns the appropriate template' do
        expect(template).to be_an_instance_of Stevenson::Templates::GitTemplate
      end

      after do
        Dir.mktmpdir do |dir|
          template.output dir
        end
      end
    end

    context 'when given a git url' do
      let(:url) { 'https://github.com/RootsRated/stevenson-base-template.git' }
      let(:template) { subject.load url }

      it 'returns the appropriate template' do
        expect(template).to be_an_instance_of Stevenson::Templates::GitTemplate
      end

      after do
        Dir.mktmpdir do |dir|
          template.output dir
        end
      end
    end

    context 'when given a path' do
      let(:path) { Dir.mktmpdir }
      let(:template) { subject.load path }

      it 'returns the appropriate template' do
        expect(template).to be_an_instance_of Stevenson::Templates::Base
      end

      after do
        FileUtils.remove_entry_secure path
        Dir.mktmpdir do |dir|
          template.output dir
        end
      end
    end
  end
end
