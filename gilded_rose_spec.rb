require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).not_to eq 'fixme'
      expect(items[0].sell_in).to eq -1
    end

    it "increases the quality of 'Aged Brie' by 1 as it gets older" do
      items = [Item.new('Aged Brie', 5, 1)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 2
      expect(items[0].sell_in).to eq 4
    end

    it "increases the quality of 'Backstage passes to a TAFKAL80ETC concert' by 2 if the sell_in value is 10 or less" do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 1)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 3
      expect(items[0].sell_in).to eq 9
    end

    it "increases the quality of 'Backstage passes to a TAFKAL80ETC concert' by 3 if the sell_in value is 5 or less" do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 1)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 4
      expect(items[0].sell_in).to eq 4
    end

    it "decreses the quality of 'Backstage passes to a TAFKAL80ETC concert' to 0 if the sell_in value is 0" do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 5)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
      expect(items[0].sell_in).to eq -1
    end

    it "neither decrease the quality of 'Sulfuras, Hand of Ragnaros' nor the sell_in" do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 5, 1)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 1
      expect(items[0].sell_in).to eq 5
    end

    it 'decrease the quality of product twice if the sell_in less than 0' do
      items = [Item.new('+5 Dexterity Vest', -1, 4)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 2
      expect(items[0].sell_in).to eq -2
    end

    it "quality does not change if it's less than 0" do
      items = [Item.new('+5 Dexterity Vest', 2, -1)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq -1
      expect(items[0].sell_in).to eq 1
    end

    it "quality does not change if it's greater than 50" do
      items = [Item.new('Elixir of the Mongoose', 2, 52)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 52
      expect(items[0].sell_in).to eq 2
    end

    it "decrease the quality of product twice if the product is 'Conjured Mana Cake'" do
      items = [Item.new('Conjured Mana Cake', 3, 4)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 2
      expect(items[0].sell_in).to eq 2
    end
  end
end
