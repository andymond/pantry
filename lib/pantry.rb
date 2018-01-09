class Pantry

  attr_reader :stock,
              :shopping_list

  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new
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
    printout = @shopping_list.reduce("") do |list, ingredient|
      list + "* #{shopping_list.invert[ingredient[1]]} : #{shopping_list[ingredient[0]]}\n"
    end
    printout
  end

end
