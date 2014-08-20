require 'spec_helper_no_rails'

describe '#make_maru' do
  before do
    stub_const('Kitten', Class.new)
    allow(kitten).to receive(:set_name)
  end

  let(:kitten) { double('a kitten') }

  context 'example #1' do
    def make_maru
      kitten = Kitten.new
      kitten.set_name('Maru')
      kitten
    end

    before do
      allow(Kitten).to receive(:new).and_return(kitten)
    end

    it 'creates and returns new kitten' do
      expect(make_maru).to be kitten
    end

    it 'passes "Maru" to the set_name method' do
      expect(kitten).to receive(:set_name).with('Maru')
      make_maru
    end
  end

  context 'example #2' do
    def make_maru
      Kitten.new do |kitten|
        kitten.set_name('Maru')
      end
    end

    before do
      allow(Kitten).to receive(:new) do |&block|
        block.call(kitten)
        kitten
      end
    end

    it 'creates and returns new kitten' do
      expect(make_maru).to be kitten
    end

    it 'passes "Maru" to the set_name method' do
      expect(kitten).to receive(:set_name).with('Maru')
      make_maru
    end
  end

  context 'example #3' do
    def make_maru
      Kitten.new do
        set_name('Maru')
      end
    end

    before do
      allow(Kitten).to receive(:new) do |&block|
        kitten.instance_eval(&block)
        kitten
      end
      allow(kitten).to receive(:set_name)
    end

    it 'creates and returns new kitten' do
      expect(make_maru).to be kitten
    end

    it 'passes "Maru" to the set_name method' do
      expect(kitten).to receive(:set_name).with('Maru')
      make_maru
    end
  end
end
