Ansi Colors
===========

This gem adds methods to colorize string using ansi escape codes.
The gem works by adding methods to the standard String class. Added
methods all starts with the prefix 'ansi_' and continue with the name
of one of the names defined in the ANSI_CMD hash in ansi_colors.rb.


Example:

	require 'ansi_colors'
		
	puts "red coloured string".ansi_red	
	puts "white and bold string".ansi_white.ansi_bold