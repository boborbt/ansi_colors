Ansi Colors
===========

This gem adds methods to colorize strings using ansi escape codes.
The gem works by adding methods to the standard String class. All
added methods start with the prefix 'ansi_' and continue with one of 
the symbols defined in the ANSI_CMD hash in ansi_colors.rb.


Example:

	require 'ansi_colors'
		
	puts "red coloured string".ansi_red	
	puts "white and bold string".ansi_white.ansi_bold
