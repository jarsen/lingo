class Lingo::Optional < Lingo::Rule
  def initialize(@inner)
  end

  def parse?(context)
    res = @inner.parse?(context)
    if res.is_a?(Lingo::Node)
      res
    else
      nil
    end
  end
end