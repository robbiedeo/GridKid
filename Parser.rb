class Token
  attr_reader :type, :text, :indices

  def initialize(type, text, indices)
    @type = type
    @text = text
    @indices = indices
  end
end

class Lexer
  def lex(source)
    @source = source
    @i = 0
    @tokens = []
    @token_so_far = ""

    while @i < @source.length
      if (has("("))
        capture
        emit_token(:leftparentheses)
      elsif (has(")"))
        capture
        emit_token(:rightparentheses)
      elsif (has("!"))
        capture
        if (has("="))
          capture
          emit_token(:doesntEqual)
        else
          emit_token(:not)
        end
        #operations
      elsif (has("*"))
        capture
        if (has("*"))
          capture
          emit_token(:exponentiation)
        else
          emit_token(:multiplication)
        end
      elsif (has("p"))
        capture
        if (has("i"))
          capture
          emit_token(:float)
        end
      elsif (has("t"))
        capture
        if (has("a"))
          capture
          if (has("u"))
            capture
            emit_token(:float)
          end
        end
      elsif (has("s"))
        capture
        if (has("u"))
          capture
          if (has("m"))
            capture
            emit_token(:sum)
          end
        end
      elsif (has("m"))
        capture
        if (has("i"))
          capture
          if (has("n"))
            capture
            emit_token(:min)
          end
        elsif (has("a"))
          capture
          if (has("x"))
            capture
            emit_token(:max)
          end
        elsif (has("e"))
          capture
          if (has("a"))
            capture
            if (has("n"))
              capture
              emit_token(:mean)
            end
          end
        end
      elsif (has("e"))
        capture
        emit_token(:float)
      elsif (has("/"))
        capture
        emit_token(:division)
      elsif (has("%"))
        capture
        emit_token(:modulo)
      elsif (has("+"))
        capture
        emit_token(:addition)
      elsif (has("-"))
        capture
        emit_token(:subtraction)
        #shifts and relational
      elsif (has(">"))
        capture
        if (has(">"))
          capture
          emit_token(:rightshift)
        elsif (has("="))
          capture
          emit_token(:greaterthanorequalto)
        else
          emit_token(:greaterthan)
        end
      elsif (has("<"))
        capture
        if (has("<"))
          capture
          emit_token(:leftshift)
        elsif (has("="))
          capture
          emit_token(:lessthanorequalto)
        else
          emit_token(:lessthan)
        end
      elsif (has("="))
        capture
        if (has("="))
          capture
          emit_token(:equality)
        end
      elsif (has("^"))
        capture
        emit_token(:bitwiseXor)
      elsif (has("&"))
        capture
        if (has("&"))
          capture
          emit_token(:and)
        else
          emit_token(:bitwiseAnd)
        end
      elsif (has("|"))
        capture
        if (has("|"))
          capture
          emit_token(:or)
        else
          emit_token(:bitwiseor)
        end
        #cell
      elsif (has("["))
        capture
        while (has_num)
          capture
          if (has(","))
            capture
          end
          if (has("]"))
            capture
          end
        end
        emit_token(:cellReference)
      elsif (has_num)
        f = false
        capture
        while (has_num)
          capture
        end
        if (has("."))
          capture
          f = true
          while (has_num)
            capture
          end
          emit_token(:float)
        else
          emit_token(:integer)
        end
      elsif (has_letters)
        capture
        while (has_letters)
          capture
        end
        if (@token_so_far.downcase == "true")
          emit_token(:boolean)
        elsif (@token_so_far.downcase == "false")
          emit_token(:boolean)
        else
          raise Exception.new "This is not an acceptable word"
        end
      else
        skip
      end
    end
    @tokens
  end

  def has_num
    @i < @source.length &&
    "0" <= @source[@i] && @source[@i] <= "9"
  end

  def has_letters
    @i < @source.length &&
    "a" <= @source[@i].downcase && @source[@i].downcase <= "z"
  end

  def has(c)
    @i < @source.length && @source[@i] == c
  end

  def capture
    @token_so_far += @source[@i]
    @i += 1
  end

  def emit_token(type)
    @tokens.push({
      type: type,
      text: @token_so_far,
    })
    @token_so_far = ""
  end

  # there is a space and we need to skip
  def skip
    @i += 1
    @token_so_far = ""
  end
end

class Parser
  require_relative("integer")
  require_relative("float")
  require_relative("boolean")
  require_relative("not")
  require_relative("environment")
  require_relative("grid")
  require_relative("and")
  require_relative("or")
  require_relative("floatToInt")
  require_relative("intToFloat")
  require_relative("relations")
  require_relative("bitOperations")
  require_relative("cell")
  require_relative("operations")

  def initialize(tokens)
    @tokens = tokens
    @i = 0
    @env = Environment.new(Grid.new)
    @s = false
    @mean = false
    @max = false
    @min = false
    @cell_one = nil
    @cell_two = nil
    @h = 0
  end

  def has(type)
    @tokens.length > @i && @tokens[@i][:type] == type
  end

  def advance
    @i += 1
  end

  def token
    @tokens[@i]
  end

  def has_ahead(type) #uses this for the parentheses
    r = @i

    for r in @tokens
      if r[:type] == type
        return true
      end
    end
    return false
  end

  def parse
    orr
  end

  # the top of the grammer
  def orr
    orr_or_lhs = andd
    while (has(:or) || has(:rightparentheses))
      if (has(:or))
        advance
        orr_or_lhs = OrLogic.new(orr_or_lhs, andd)
      elsif (has(:rightparentheses))
        advance
      end
    end
    orr_or_lhs
  end

  def andd
    and_or_lhs = bitwiseOr
    while (has(:and))
      if (has(:and))
        advance
        and_or_lhs = AndLogic.new(and_or_lhs, bitwiseOr)
      end
    end
    and_or_lhs
  end

  def bitwiseOr
    bitwiseOr_or_lhs = bitwiseXor
    while (has(:bitwiseor))
      if (has(:bitwiseor))
        advance
        bitwiseOr_or_lhs = OrBit.new(bitwiseOr_or_lhs, bitwiseXor)
      end
    end
    bitwiseOr_or_lhs
  end

  def bitwiseXor
    bitwiseAnd_or_lhs = bitwiseAnd
    while (has(:bitwiseXor))
      if (has(:bitwiseXor))
        advance
        bitwiseAnd_or_lhs = XorBit.new(bitwiseAnd_or_lhs, bitwiseAnd)
      end
    end
    bitwiseAnd_or_lhs
  end

  def bitwiseAnd
    equality_or_lhs = equality
    while (has(:bitwiseAnd))
      if (has(:bitwiseAnd))
        advance
        equality_or_lhs = AndBit.new(equality_or_lhs, equality)
      end
    end
    equality_or_lhs
  end

  def equality
    relational_or_lhs = relational
    while (has(:equality) || has(:doesntEqual))
      if (has(:equality))
        advance
        relational_or_lhs = Equals.new(relational_or_lhs, relational)
      elsif (has(:doesntEqual))
        advance
        relational_or_lhs = NotEquals.new(relational_or_lhs, relational)
      end
    end
    relational_or_lhs
  end

  def relational
    shifts_or_lhs = shifts
    while (has(:lessthan) || has(:lessthanorequalto) || has(:greaterthan) || has(:greaterthanorequalto))
      if (has(:lessthan))
        advance
        shifts_or_lhs = LessThan.new(shifts_or_lhs, shifts)
      elsif (has(:lessthanorequalto))
        advance
        shifts_or_lhs = LessThanOrEqualTo.new(shifts_or_lhs, shifts)
      elsif (has(:greaterthan))
        advance
        shifts_or_lhs = GreaterThan.new(shifts_or_lhs, shifts)
      elsif (has(:greaterthanorequalto))
        advance
        shifts_or_lhs = GreaterThanOrEqualTo.new(shifts_or_lhs, shifts)
      end
    end
    shifts_or_lhs
  end

  def shifts
    addSub_or_lhs = add_sub
    while (has(:leftshift) || has(:rightshift))
      if (has(:leftshift))
        advance
        addSub_or_lhs = Leftshift.new(addSub_or_lhs, add_sub)
      elsif (has(:rightshift))
        advance
        addSub_or_lhs = Rightshift.new(addSub_or_lhs, add_sub)
        # else
        #     add_sub
      end
    end
    addSub_or_lhs
  end

  def add_sub
    mult_or_lhs = mult_div
    while (has(:addition) || has(:subtraction))
      if (has(:addition))
        advance
        mult_or_lhs = AdditionV.new(mult_or_lhs, mult_div)
      elsif (has(:subtraction))
        advance
        mult_or_lhs = SubtractionV.new(mult_or_lhs, mult_div)
        # else
        #     note
      end
    end
    mult_or_lhs
  end

  def mult_div
    expo_or_lhs = exponentiation
    while (has(:multiplication) || has(:division) || has(:modulo))
      if (has(:multiplication))
        advance
        expo_or_lhs = MultiplicationV.new(expo_or_lhs, exponentiation)
      elsif (has(:division))
        advance
        expo_or_lhs = DivisionV.new(expo_or_lhs, exponentiation)
      elsif (has(:modulo))
        advance
        expo_or_lhs = ModuloV.new(expo_or_lhs, exponentiation)
      end
    end
    expo_or_lhs
  end

  def exponentiation
    note_or_lhs = note
    while (has(:exponentiation))
      if (has(:exponentiation))
        advance
        note_or_lhs = ExponentiationV.new(note_or_lhs, note)
      else
        note_or_lhs = note
      end
    end
    note_or_lhs
  end

  def note
    expr = nil
    if (has(:not))
      advance
      expr = NotBool.new(note)
    else
      expr = atom
    end
    expr
  end

  def atom
    expr = nil
    while (has(:integer) || has(:float) || has(:boolean) || has(:leftparentheses) || has(:cellReference) || has(:sum) || has(:mean) || has(:max) || has(:min))
      if has(:integer)
        expr = IntegerV.new(token[:text].to_i)
        advance
      elsif has(:float)
        if token[:text] == "pi"
          expr = @env.getVariable("pi")
          advance
        elsif token[:text] == "e"
          expr = @env.getVariable("e")
          advance
        elsif token[:text] == "tau"
          expr = @env.getVariable("tau")
          advance
        else
          expr = FloatV.new(token[:text].to_f)
          advance
        end
      elsif has(:boolean)
        expr = BoolV.new(token[:text] == "true")
        advance
      elsif has(:cellReference)
        # handles the cell reference by removing the brackets
        s = token[:text].sub("[", "")
        s = s.sub("]", "")
        leftNum, rightNum = s.split(",")
        @cell_one, expr = Cell.new(leftNum.to_i, rightNum.to_i)
        if (@s || @mean || @max || @min)
          @h += 1
          if @h == 2
            @cell_two, expr = Cell.new(leftNum.to_i, rightNum.to_i)
          end
        end
        advance
      elsif has(:leftparentheses)
        advance
        if (has_ahead(:rightparentheses))
          expr = parse
        end
      elsif has(:sum || @s)
        @s = true
        @h += 1
        advance
      elsif has(:mean)
        @mean = true
        @h += 1
        advance
      elsif has(:max)
        @max = true
        @h += 1
        advance
      elsif has(:min)
        @min = true
        @h += 1
        advance
      end
    end
    if (@s)
      expr = SumV.new(@cell_two, @cell_one)
    elsif (@mean)
      expr = MeanV.new(@cell_two, @cell_one)
    elsif (@max)
      expr = MaxV.new(@cell_two, @cell_one)
    elsif (@min)
      expr = MinV.new(@cell_two, @cell_one)
    end
    expr
  end
end
