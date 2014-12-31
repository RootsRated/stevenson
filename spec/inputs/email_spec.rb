describe Stevenson::Inputs::Email do
  describe '#initialize' do
    let(:text_input) { Stevenson::Inputs::Email.new({}) }

    it 'creates a new email input' do
      expect(text_input).to be_an_instance_of Stevenson::Inputs::Email
    end
  end

  describe '#collect!' do
  end
end
