require "curses"

# initialize curses
Curses.init_screen
Curses.noecho # disable echoing of typed characters
Curses.cbreak # immediately respond to user input

# create a window
win = Curses::Window.new(10, 30, 0, 0) # height, width, top, left
win.box("|", "-") # add a border to the window
win.setpos(1, 1)
win.addstr("Enter some text:")

# get user input
win.setpos(2, 1)
input = win.getstr

# print the user input
win.setpos(4, 1)
win.addstr("You entered: #{input}")

# wait for user input before closing the window
win.getch

# close the window and end curses
win.close
Curses.close_screen
