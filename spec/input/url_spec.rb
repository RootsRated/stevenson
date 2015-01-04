describe Stevenson::Input::Url do
  describe '#initialize' do
    let(:text_input) { Stevenson::Input::Url.new({}) }

    it 'creates a new url input' do
      expect(text_input).to be_an_instance_of Stevenson::Input::Url
    end
  end

  describe '#collect!' do
  end
end
