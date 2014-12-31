describe Stevenson::Inputs::Url do
  describe '#initialize' do
    let(:text_input) { Stevenson::Inputs::Url.new({}) }

    it 'creates a new url input' do
      expect(text_input).to be_an_instance_of Stevenson::Inputs::Url
    end
  end

  describe '#collect!' do
  end
end
