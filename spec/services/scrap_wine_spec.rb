require 'rails_helper'


RSpec.describe ScrapWine.new do

  subject(:scrap_wine){described_class.rating_average}
  context 'When a array is passed note is given' do

    it 'sould return a note' do
      expect(ScrapWine.new.rating_average(['50/20','50/100'])).to eq(50)
    end
  end
end
