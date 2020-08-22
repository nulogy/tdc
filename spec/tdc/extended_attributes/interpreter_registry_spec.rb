RSpec.describe Tdc::ExtendedAttributes::InterpreterRegistry do
  subject(:registry) { described_class.instance }

  it "return the default interpreter when there are no registered interpreters" do
    expect(registry.interpreters).to contain_exactly(a_kind_of(Tdc::ExtendedAttributes::DefaultInterpreter))
  end

  it "return the registered interpreters" do
    interpreter_1 = create_interpreter
    interpreter_2 = create_interpreter

    registry.register_interpreter(interpreter_1)
    registry.register_interpreter(interpreter_2)

    expect(registry.interpreters).to contain_exactly(interpreter_1, interpreter_2)
  end

  it "fails to register an invalid interpreter" do
    expect { registry.register_interpreter(self) }.to raise_error(
      Tdc::FatalError, "Cannot register an interpreter unless it inherits from Tdc::ExtendedAttributes::InterpreterBase"
    )
  end

  def create_interpreter
    Class.new(Tdc::ExtendedAttributes::InterpreterBase) do
      def interpret(_instance_definition)
      end
    end.new
  end
end
