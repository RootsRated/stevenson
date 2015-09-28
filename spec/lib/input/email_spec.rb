describe Stevenson::Input::Email do
  describe '#initialize' do
    let(:text_input) { Stevenson::Input::Email.new({}) }

    it 'creates a new email input' do
      expect(text_input).to be_an_instance_of Stevenson::Input::Email
    end
  end

  describe '#collect!' do
  end
end
