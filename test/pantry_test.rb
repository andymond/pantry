require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_it_start_with_empty_stock
    pantry = Pantry.new

    assert_equal({}, pantry.stock)
  end

  def test_it_can_check_stock
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_it_can_restock
    pantry = Pantry.new

    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 20)

    assert_equal 30, pantry.stock_check("Cheese")
  end

  def test_it_has_shopping_list
    pantry = Pantry.new

    assert_equal({}, pantry.shopping_list)
  end

  def test_it_can_add_to_shopping_list
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")

    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)

    assert_equal({"Cheese" => 20, "Flour" => 20}, pantry.shopping_list)

    r = Recipe.new("Spaghetti")
    r.add_ingredient("Spaghetti Noodles", 10)
    r.add_ingredient("Marinara Sauce", 10)
    r.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r)

    list = {"Cheese" => 25, "Flour" => 20,
            "Spaghetti Noodles" => 10, "Marinara Sauce" => 10}

    assert_equal(list, pantry.shopping_list)
  end

  def test_it_can_print_shopping_list
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")

    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)

    assert_equal({"Cheese" => 20, "Flour" => 20}, pantry.shopping_list)

    r = Recipe.new("Spaghetti")
    r.add_ingredient("Spaghetti Noodles", 10)
    r.add_ingredient("Marinara Sauce", 10)
    r.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r)

    printout = "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"

    assert_equal printout, pantry.print_shopping_list
  end

  def test_it_starts_with_empty_cookbook
    pantry = Pantry.new

    assert_equal [], pantry.cookbook
  end

  def test_it_can_add_to_cookbook
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    pantry.cookbook.each do |recipe|
      assert_instance_of Recipe, recipe
    end
    pantry.cookbook.each do |recipe|
      assert_equal 2, recipe.ingredients.count
    end
  end



end
