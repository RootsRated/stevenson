describe Stevenson::Input::Text do
  describe '#initialize' do
    let(:text_input) { Stevenson::Input::Text.new({}) }

    it 'creates a new text input' do
      expect(text_input).to be_an_instance_of Stevenson::Input::Text
    end
  end

  describe '#collect!' do
  end
end
