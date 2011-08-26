# Adds several useful methods to strings
class String
  # The color commands understood by the overridden method_missing method.
  ANSI_CMDS = {
    :reset                =>    0,
    :bright               =>    1,
    :bold                 =>    1,
    :faint                =>    2,
    :italic               =>    3,
    :underline            =>    4,
    :blink_slow           =>    5,
    :blink_rapid          =>    6,
    :inverse              =>    7,
    :conceal              =>    8,
    :crossed_out          =>    9,
    :underline2           =>    21,
    :normal               =>    22,
    :black                =>    30,
    :red                  =>    31,
    :green                =>    32,
    :yellow               =>    33,
    :blue                 =>    34,
    :magenta              =>    35,
    :cyan                 =>    36,
    :white                =>    37,
    :default_color        =>    39,
    :bck_black            =>    40,
    :bck_red              =>    41,
    :bck_green            =>    42,
    :bck_yellow           =>    43,
    :bck_blue             =>    44,
    :bck_magenta          =>    45,
    :bck_cyan             =>    46,
    :bck_white            =>    47,
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
  def colorize(col_code)
    "\033[#{col_code}m#{self}\033[0m"
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
    
    clr_id = ANSI_CMDS[symbol.to_s[5..-1].to_sym]
    if clr_id
      colorize(clr_id)
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