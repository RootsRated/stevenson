describe Stevenson::Input::Select do
  describe '#initialize' do
    let(:text_input) { Stevenson::Input::Select.new({}) }

    it 'creates a new selection input' do
      expect(text_input).to be_an_instance_of Stevenson::Input::Select
    end
  end

  describe '#collect!' do
  end
end
