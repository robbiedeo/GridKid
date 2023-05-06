class IntegerV
    def initialize(i)
        @i = i
    end
    def getI
        @i
    end
    def evaluate(env)
        self
    end

    def to_string()
        "#{@i}"
    end
end
