class Int_to_Float

    def initialize(f)
        @f = f
    end

    def f
        @f
    end

    def evaluate(env)
        fv = f.to_f
        return FloatV.new(fv)
    end
end