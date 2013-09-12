module IngredientsHelper

  def simplify(number)
    number.to_s.gsub(/[0+]\z/, '').gsub(/\.\z/, '')
  end
end
