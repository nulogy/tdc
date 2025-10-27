# frozen_string_literal: true

RSpec.describe Tdc::ExtendedAttributes::InterpreterRegistry do
  subject(:registry) { described_class.instance }

  before do
    registry.clear
  end

  it "returns the default interpreter when there are no registered interpreters" do
    expect(registry.interpreters).to contain_exactly(a_kind_of(Tdc::ExtendedAttributes::DefaultInterpreter))
  end

  it "returns the registered interpreters" do
    interpreter_1 = create_interpreter_1
    interpreter_2 = create_interpreter_2

    registry.register_interpreter(interpreter_1)
    registry.register_interpreter(interpreter_2)

    expect(registry.interpreters).to contain_exactly(interpreter_1, interpreter_2)
  end

  it "avoids registering the same interpreter a second time" do
    interpreter_1 = create_interpreter_1
    interpreter_2 = create_interpreter_2

    registry.register_interpreter(interpreter_1)
    registry.register_interpreter(interpreter_2)
    registry.register_interpreter(interpreter_2)

    expect(registry.interpreters).to contain_exactly(interpreter_1, interpreter_2)
  end

  it "fails to register an invalid interpreter" do
    expect { registry.register_interpreter(self) }.to raise_error(
      Tdc::FatalError, "Cannot register an interpreter unless it inherits from Tdc::ExtendedAttributes::InterpreterBase"
    )
  end

  def create_interpreter_1
    Class.new(Tdc::ExtendedAttributes::InterpreterBase) do
      def interpret(_instance_definition)
      end
    end.new
  end

  def create_interpreter_2
    Class.new(Tdc::ExtendedAttributes::InterpreterBase) do
      def interpret(_instance_definition)
      end
    end.new
  end
end
