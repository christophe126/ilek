require 'rails_helper'

RSpec.describe Wine, type: :model do

  context 'When a whine sould be saved' do
    before do
      Wine.create!(name: "Vins du Sud", rating: 90)
    end
    it 'sould persist a wine' do
      expect(Wine.count).to eq(1)
    end

    let(:wine) { Wine.create(name: 'Vins du Sud', rating: 90) }
    it 'wine should a rating 90' do
      # binding.break
      expect(wine.rating).to eq(90)
    end

    let(:wine) { Wine.create(name: 'Vins du Sud', rating: 90) }
    it 'wine should a name Vins du Sud' do
      # binding.break
      expect(wine.name).to eq('Vins du Sud')
    end


  end
end
