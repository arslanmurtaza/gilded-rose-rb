require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'

class TestUntitled < Test::Unit::TestCase
  def test_foo
    items = [Item.new('foo', 0, 0)]
    GildedRose.new(items).update_quality
    assert_not_equal items[0].name, 'fixme'
  end

  def test_aged_brie
    items = [Item.new('Aged Brie', 5, 1)]
    GildedRose.new(items).update_quality
    assert_equal items[0].quality, 2
    assert_equal items[0].sell_in, 4
  end

  def test_backstage_with_10
    items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 1)]
    GildedRose.new(items).update_quality
    assert_equal items[0].quality, 3
    assert_equal items[0].sell_in, 9
  end

  def test_backstage_with_5
    items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 1)]
    GildedRose.new(items).update_quality
    assert_equal items[0].quality, 4
    assert_equal items[0].sell_in, 4
  end

  def test_backstage_with_0
    items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 5)]
    GildedRose.new(items).update_quality
    assert_equal items[0].quality, 0
    assert_equal items[0].sell_in, -1
  end

  def test_sulfuras
    items = [Item.new('Sulfuras, Hand of Ragnaros', 5, 1)]
    GildedRose.new(items).update_quality
    assert_equal items[0].quality, 1
    assert_equal items[0].sell_in, 5
  end

  def test_negative_sell_in
    items = [Item.new('+5 Dexterity Vest', -1, 4)]
    GildedRose.new(items).update_quality
    assert_equal items[0].quality, 2
    assert_equal items[0].sell_in, -2
  end

  def test_negative_quality
    items = [Item.new('+5 Dexterity Vest', 2, -1)]
    GildedRose.new(items).update_quality
    assert_equal items[0].quality, -1
    assert_equal items[0].sell_in, 1
  end

  def test_quality_greater_than_50
    items = [Item.new('Elixir of the Mongoose', 2, 52)]
    GildedRose.new(items).update_quality
    assert_equal items[0].quality, 52
    assert_equal items[0].sell_in, 2
  end

  def test_conjured
    items = [Item.new('Conjured Mana Cake', 3, 4)]
    GildedRose.new(items).update_quality
    assert_equal items[0].quality, 2
    assert_equal items[0].sell_in, 2
  end
end
