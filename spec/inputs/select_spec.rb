describe Stevenson::Inputs::Select do
  describe '#initialize' do
    let(:text_input) { Stevenson::Inputs::Select.new({}) }

    it 'creates a new selection input' do
      expect(text_input).to be_an_instance_of Stevenson::Inputs::Select
    end
  end

  describe '#collect!' do
  end
end
