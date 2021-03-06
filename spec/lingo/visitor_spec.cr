require "../spec_helper"

describe "Lingo::Visitor" do
  describe "#visit" do
    it "transforms parse result, bottom-up" do
      return_value = Math.eval("-10+1")
      return_value.should eq(-9)

      parse_result = Math.parser.parse("5*3")
      visitor = Math.visitor
      visitor.visit(parse_result)
      return_value = visitor.values.pop
      return_value.should eq(15)
    end
  end
end
