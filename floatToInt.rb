class Float_to_Int

    def initialize(i)
        @i = i
    end

    def i
        @i
    end

    def evaluate(env)
        intPrim = IntegerV.new(i.to_i)
        return intPrim
    end
end