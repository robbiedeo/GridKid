class BoolV
    def initialize(bool)
        @bool = bool
    end

    def evaluate(env)
        self
    end

    def getBool
        @bool
    end

    def to_string()
        "#{@bool}"
    end
end