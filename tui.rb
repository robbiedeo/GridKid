require "curses"
require_relative("grid")
require_relative("Parser")

# COL_LETTER = {}
# ROW_NUMS = {}
# letters = "a"
# num = 1
# # only 10 letters
# 11.step(110, 10).map do |i|
#   COL_LETTER[i] = letters
#   letters = letters.next
# end
# 11.step(51, 2).map do |j|
#   ROW_NUMS[j] = num
#   num += 1
# end

class GridKid
  attr_accessor :grid_win, :formula_win, :display_win, :rows, :cols, :grid, :selected_col, :selected_row, :lexer, :parser, :grid

  def initialize
    Curses.init_screen
    Curses.start_color
    Curses::init_pair(1, Curses::COLOR_BLACK, Curses::COLOR_RED)
    Curses::use_default_colors

    Curses.noecho
    Curses.cbreak
    Curses::stdscr.keypad = true # enables keypad input
    Curses.curs_set(15)
    Curses::attron(Curses::A_REVERSE)
    @rows, @cols = Curses.lines, Curses.cols
    @formula_win = Curses::Window.new(4, cols / 2, 0, 0)
    @display_win = Curses::Window.new(4, cols / 2, 0, cols / 2)
    @grid_win = Curses::Window.new(rows - 5, cols - 4, 4, 0)
    @cur_width = 8
    @cur_height = 2
    #@grid_win = Curses.stdscr
    @grid = Grid.new
    @env = Environment.new(@grid)
    @selected_row, @selected_col = 10, 3
    #use reverse for the foreground and backgroudn highlight
  end

  def formula_window_settings
    #formula
    formula_win.box()
    formula_win.setpos(1, 1)
    formula_win.addstr("Formula editor: ")
    #formula_win.addstr(str)
    Curses::refresh
    formula_win.refresh
  end

  def display_window_settings()
    #display
    display_win.box()
    display_win.setpos(1, 1)
    display_win.addstr("Display Panel: ")
    # display_win.addstr(str.to_s)
    display_win.refresh
  end

  def display_settings
    # Print row numbers at the top
    row_num = 1
    for x in 6..cols - 2
      if x % 8 == 6
        grid_win.setpos(1, x + 4)
        grid_win.addstr(row_num.to_s)
        row_num += 1
      end
    end

    # Print column letters at the side
    letter = "a"
    for y in 2..rows - 2
      if y % 2 == 0
        grid_win.setpos(y + 1, 2)
        grid_win.addstr(letter)
        letter = letter.next
      end
    end

    # Print grid lines
    for x in 6..cols
      for y in 2..rows
        grid_win.setpos(y, x)
        if x % 8 == 6 and y % 2 == 0
          grid_win.addch("┼")
        elsif y % 2 == 0
          grid_win.addch("─")
        elsif x % 8 == 6
          grid_win.addch("│")
        end
      end
    end

    formula_window_settings()
    display_window_settings()
    formula_win.refresh
    display_win.refresh
    grid_win.refresh
    Curses::refresh
  end

  #evalute the expression using the lexer and parser
  def expression_evaluated(source)
    lexer = Lexer.new
    tokens = lexer.lex(source)
    parser = Parser.new(tokens)
    expr = parser.parse
    expr
  end

  #populate the grid with the cell
  def cell_populate(x, y, expression)
    # p expression
    cell = Cell.new(y, x)
    grid.gridSetter(cell, expression[1..])
    grid_win.setpos(y, x)
    grid_win.addstr(expression_evaluated(expression[1..]).evaluate(@env).to_string)
  end

  # #return the evaluated cell
  # def cell_evaluated(x, y)
  #   row = ROW_NUMS[y]
  #   col = COL_LETTER[x]
  #   cell = Cell.new(col, row)
  #   evaluated = grid.gridGetter(cell).evaluate(env).to_s
  #   return evaluated
  # end

  def formula_win_text(x, y)
    cell = Cell.new(x, y)
    cellForm = grid.gridGetter(cell)
    # p cellForm
    if cellForm != nil
      formula_win.addstr(grid.gridGetter(cell))
    else
      formula_win.clear
    end
    formula_win::refresh
    Curses::refresh
  end

  def display_win_text(x, y)
    cell = Cell.new(x, y)
    cellForm = grid.gridGetter(cell)
    # p cellForm
    if cellForm != nil
      display_win.addstr(expression_evaluated(grid.gridGetter(cell)).evaluate(@env).to_string)
    else
      display_win.clear
    end
    display_win::refresh
    Curses::refresh
  end

  def editor(y, x)
    cell = Cell.new(y, x)
    if grid.gridGetter(cell) == nil
      equation = ""
    else
      equation = grid.gridGetter(cell)
    end
    loop do
      input = formula_win.getch
      if input.chr == "q"
        Curses.close_screen
        exit(1)
      else
        case input
        # when Curses::KEY_BACKSPACE, 127 # 127 is ASCII code for backspace
        #   formula_win.delch
        #   formula_win.refresh
        #   # equation = equation.chop
        when Curses::KEY_ENTER, 10
          break
        else
          formula_win.addch(input)
          equation += input
          formula_win.refresh
        end
        Curses::refresh
      end
    end
    # if we need to evaluate then call the method
    if (equation[0] == "=")
      cell_populate(x, y, equation)
    end
    #clear the window
    formula_win.clear
  end

  def inputs
    grid_win.setpos(@selected_col, @selected_row)
    case grid_win.getch
    when "W", "w", Curses::Key::UP
      @selected_col -= @cur_height
    when "s", "S", Curses::KEY_DOWN
      if @selected_col < (cols - 1)
        @selected_col += @cur_height
      end
    when "a", "A", Curses::KEY_LEFT
      @selected_row -= @cur_width
    when "d", "D", Curses::KEY_RIGHT
      @selected_row += @cur_width
    when "q"
      Curses.close_screen
      exit(1)
    when "e"
      editor(@selected_row, @selected_col)
    end
    grid_win.setpos(@selected_col, @selected_row)
    formula_win_text(@selected_row, @selected_col)
    display_win_text(@selected_row, @selected_col)
    grid_win.refresh
    display_win.refresh
    formula_win.refresh
    Curses::refresh
  end

  def run
    # begin
    loop do
      display_settings
      inputs
    end
  end
end

kid = GridKid.new
kid.run
