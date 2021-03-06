class Lingo::Sequence < Lingo::Rule
  alias Parts = Array(Lingo::Rule)
  getter :parts
  @parts : Parts

  def initialize(incoming_parts = Parts.new, @name = nil.as(String?))
    new_parts = Parts.new
    incoming_parts.each do |input|
      if input.is_a?(Lingo::Sequence)
        new_parts += input.parts
      else
        new_parts << input
      end
    end
    @parts = new_parts
  end

  def parse?(context : Lingo::Context)
    sequence_parent = Lingo::Node.new(name: @name, line: context.line, column: context.column)
    new_context = context.fork(root: sequence_parent)

    results = parts.map do |matcher|
      success = matcher.parse?(new_context)
      if !success
        break
      end
    end

    # Break causes it to be nil
    if results.is_a?(Array) && parts.size == results.size
      context.join(new_context)
      true
    else
      false
    end
  end
end
