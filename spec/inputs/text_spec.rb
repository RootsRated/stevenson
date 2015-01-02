describe Stevenson::Inputs::Text do
  describe '#initialize' do
    let(:text_input) { Stevenson::Inputs::Text.new({}) }

    it 'creates a new text input' do
      expect(text_input).to be_an_instance_of Stevenson::Inputs::Text
    end
  end

  describe '#collect!' do
  end
end
