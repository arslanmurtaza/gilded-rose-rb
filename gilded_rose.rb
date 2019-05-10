class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if item.quality > 50

      update_conjured_item(item) && next if item.name == 'Conjured Mana Cake'

      if (item.name != 'Aged Brie') &&
         (item.name != 'Backstage passes to a TAFKAL80ETC concert')
        item = decrease_quality_by_one(item) if item.quality > 0
      elsif item.quality < 50
        item = increase_quality_by_one(item)
        item = update_backstage_quality(item) if item.name == 'Backstage passes to a TAFKAL80ETC concert'
      end

      item = decrease_sell_in_by_one(item) if item.name != 'Sulfuras, Hand of Ragnaros'
      update_quality_for_negative_sell_in(item) if item.sell_in < 0
    end
  end

  def decrease_quality_twice(item)
    item.quality = (item.quality / 2).to_i
    item
  end

  def decrease_quality_by_one(item)
    item.quality = item.quality - 1 if item.name != 'Sulfuras, Hand of Ragnaros'
    item
  end

  def increase_quality_by_one(item)
    item.quality = item.quality + 1
    item
  end

  def decrease_sell_in_by_one(item)
    item.sell_in = item.sell_in - 1
    item
  end

  def update_backstage_quality(item)
    item = increase_quality_by_one(item) if item.quality < 50 &&
                                            item.sell_in < 11
    item = increase_quality_by_one(item) if item.quality < 50 &&
                                            item.sell_in < 6
    item
  end

  def update_quality_for_negative_sell_in(item)
    if item.name != 'Aged Brie'
      if item.name != 'Backstage passes to a TAFKAL80ETC concert'
        item = decrease_quality_by_one(item) if item.quality > 0
      else
        item.quality = item.quality - item.quality
      end
    elsif item.quality < 50
      item = increase_quality_by_one(item)
    end
    item
  end

  def update_conjured_item(item)
    decrease_sell_in_by_one(item)
    decrease_quality_twice(item)
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
