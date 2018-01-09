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
    printout = ""
    @shopping_list.each_pair do |ingredient, amount|
      printout += "* #{ingredient}: #{amount}\n"
    end
    printout.chomp
  end

end
