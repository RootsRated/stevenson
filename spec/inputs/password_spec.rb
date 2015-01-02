describe Stevenson::Inputs::Password do
  describe '#initialize' do
    let(:text_input) { Stevenson::Inputs::Password.new({}) }

    it 'creates a new password input' do
      expect(text_input).to be_an_instance_of Stevenson::Inputs::Password
    end
  end

  describe '#collect!' do
  end
end
