# Adds several useful methods to strings
class String
  # The color commands understood by the overridden method_missing method.
  ANSI_CMDS = {
    :bright               =>    [1, :normal],
    :bold                 =>    [1, :normal],
    :faint                =>    [2, :normal],
    :italic               =>    [3, 23],
    :underline            =>    [4, 24],
    :blink_slow           =>    [5, 25],
    :blink_rapid          =>    [6, 26],
    :inverse              =>    [7, 27],
    :conceal              =>    [8, 28],
    :crossed_out          =>    [9, 29],
    :black                =>    [30, :default_color],
    :red                  =>    [31, :default_color],
    :green                =>    [32, :default_color],
    :yellow               =>    [33, :default_color],
    :blue                 =>    [34, :default_color],
    :magenta              =>    [35, :default_color],
    :cyan                 =>    [36, :default_color],
    :white                =>    [37, :default_color],
    :bck_black            =>    [40, :default_background],
    :bck_red              =>    [41, :default_background],
    :bck_green            =>    [42, :default_background],
    :bck_yellow           =>    [43, :default_background],
    :bck_blue             =>    [44, :default_background],
    :bck_magenta          =>    [45, :default_background],
    :bck_cyan             =>    [46, :default_background],
    :bck_white            =>    [47, :default_background],
    :reset                =>    0,
    :normal               =>    22,
    :default_color        =>    39,
    :default_background   =>    49		
  }
  
  # Returns a quoted version of the string)
  def quote
    %Q{"#{self}"}
  end
  
  # Unquote a quoted string (e.g. "'test'".quote => 'test'
  def unquote
    match = /"(.*)"/.match(self)
    match ?  match[1] : self
  end
  
  # Adds escape chars to the string so that it appears coloured when printed on an
  # ansi compliant terminal (non-ansi terminals will display the string surrounded
  # by garbage-like stuff). col_code specifies the color to be used. 
  def colorize(col_code, end_code)
    "\033[#{col_code}m#{self}\033[#{end_code}m"
  end
  
  # Override method_missing in order to add methods to colorize the string. The
  # supported methods starts with the string 'ansi_' followed by the color to be
  # used. Some examples:
  #   - str.ansi_blue will change the foreground color of string 'str' to blue
  #   - str.ansi_bck_red will change the background color of string 'str' to red
  # see ANSI_CMDS for a list of available commands. Combination are possible. Some
  # examples:
  #   - str.ansi_blue.ansi_bck_red.ansi_bold will change str so to appear as a bold blue text on a red background
  def method_missing symbol, *others
    if symbol.to_s !~ /\Aansi_.*\Z/
      return super      
    end

    color_code = ANSI_CMDS[symbol.to_s[5..-1].to_sym]
    end_code = :reset
    if color_code.is_a?(Array)
      color_code, end_code = color_code
    end
    if end_code.is_a?(Symbol)
      end_code = ANSI_CMDS[end_code]
    end

    if color_code
      colorize(color_code, end_code)
    else
      raise "Unknown ansi code"
    end
  end

  # returns true if the stripped version of the string has zero lenght (i.e., 
  # if the string is empty or contains only space characters)
  def blank?
    self.strip.size == 0
  end

end
