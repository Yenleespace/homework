require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  let(:honeybread) { Dessert.new("honeybread", 100, chef)}

  describe "#initialize" do
    it "sets a type" do
    expect(honeybread.type).to eq("honeybread")
    end

    it "sets a quantity" do
      expect(honeybread.quantity).to eq(100)
    end

    it "starts ingredients as an empty array" do
      expect(honeybread.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect{Dessert.new("bananabread", "bake")}
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      honeybread.add_ingredient("honey")
      expect(honeybread.ingredients).to include("honey")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      honeybread.ingredients.shuffle!
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      honeybread.eat(10)
      expect(honeybread.quantity).to eq(90)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect{honeybread.eat(101)}.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      # expect(chef.titleize).to include(honey.serve)
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      # expect(:chef.bake).to(honeybread)
    end
  end
end
