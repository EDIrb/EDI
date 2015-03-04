class Dice < EDI::Service
  attr_accessor :dice_result
  phrases "roll", "dice"
  before_invoke :perform_roll

  def run
    "You got a #{dice_result}"
  end

private

  def perform_roll
    input = extract_dice_expression.split("d").map(&:to_i)
    self.dice_result = input[0].times.map{ roll input[1] }.inject(:+)
  end

  def extract_dice_expression
    text[/(\d+[d]\d+)/]
  end

  def roll(sides)
    Random.rand(sides)
  end

end
