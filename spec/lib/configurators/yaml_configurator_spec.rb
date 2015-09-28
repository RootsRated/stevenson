describe Stevenson::Configurator::YAMLConfigurator do
  describe '#initialize' do
    let(:temporary_directory) { Dir.mktmpdir }
    let(:yaml_configurator) { Stevenson::Configurator::YAMLConfigurator.new temporary_directory }

    it 'creates a new configurator' do
      expect(yaml_configurator).to be_an_instance_of Stevenson::Configurator::YAMLConfigurator
    end

    after { FileUtils.remove_entry_secure temporary_directory }
  end
end
