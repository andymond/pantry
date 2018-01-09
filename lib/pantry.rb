class Pantry

  attr_reader :stock,
              :shopping_list,
              :cookbook

  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new
    @cookbook = []
  end

  def stock_check(item)
    @stock[item]
  end

  def restock(item, quantity)
    @stock[item] += quantity
  end

  def add_to_shopping_list(recipe)
    @shopping_list.merge!(recipe.ingredients) do |ingredient, current_amount, new_amount|
      current_amount + new_amount
    end
  end

  def print_shopping_list
    printout = ""
    @shopping_list.each_pair do |ingredient, amount|
      printout += "* #{ingredient}: #{amount}\n"
    end
    printout.chomp
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def recipes_with_ingredients
    ingredients_per_recipe = {}
    cookbook.each do |recipe|
      ingredients_per_recipe[recipe.name] = recipe.ingredients
    end
    ingredients_per_recipe
  end

  def what_can_I_make?
    stock.map do |stock_item|
      recipes_with_ingredients.select do |recipe, ingredients|
        ingredients.include?(stock_item)
      end
    end
  end

end
