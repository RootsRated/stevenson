describe Stevenson::Input::Password do
  describe '#initialize' do
    let(:text_input) { Stevenson::Input::Password.new({}) }

    it 'creates a new password input' do
      expect(text_input).to be_an_instance_of Stevenson::Input::Password
    end
  end

  describe '#collect!' do
  end
end
