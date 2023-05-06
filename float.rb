class FloatV
    def initialize(f)
        @f = f
    end
    def getF
        @f
    end
    def evaluate(env)
        self
    end

    def to_string()
        "#{@f}"
    end
end
