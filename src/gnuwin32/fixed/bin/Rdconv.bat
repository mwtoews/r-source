@rem = '
@echo off
perl.exe %R_HOME%\bin\Rdconv.bat %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
@rem ';
# Convert R documentation into HTML, LaTeX and text format

# Copyright (C) 1997 Friedrich Leisch
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the GNU
# General Public License for more details.
#
# A copy of the GNU General Public License is available via WWW at
# http://www.gnu.org/copyleft/gpl.html.	 You can also obtain it by
# writing to the Free Software Foundation, Inc., 59 Temple Place,
# Suite 330, Boston, MA  02111-1307  USA.

# Send any bug reports to Friedrich.Leisch@ci.tuwien.ac.at

use Getopt::Long;
use File::Basename;
use Cwd;

my $revision = ' $Revision: 1.1.2.1 $ ';
my $version;
my $name;

$revision =~ / ([\d\.]*) /;
$version = $1;
($name = $0) =~ s|.*/||;

sub version {
  print STDERR <<END;
Rdconv $version
Copyright (C) 1997-2000 R Core Development Team
This is free software; see the GNU General Public Licence version 2
or later for copying conditions.  There is NO warranty.    
END
  exit 0;
}

sub usage {
  print STDERR <<END;
Usage: Rdconv.bat [options] FILE

Convert R documentation in FILE to other formats such as plain text,
HTML or LaTeX.

Options:
  -h, --help		print short help message and exit
  -v, --version		print version info and exit
  -d, --debug		turn on debugging (increase verbosity)
  -t, --type=TYPE	convert to format TYPE
  --os=NAME		use OS subdir \`NAME\' (unix, mac or windows)
  --OS=NAME		the same as --os.

Possible format specificiations are html, latex, txt (plain text), 
Sd (S documentation format), and example (extract R code in the examples).
  
Email bug reports to <r-bugs\@lists.r-project.org>.
END
  exit 0;
}

my $OSdir ="windows";

$cwd=getcwd();
if($ENV{"R_HOME"}){
    $R_HOME=$ENV{"R_HOME"};
}
else{
    print "Must set R_HOME to use Rdconv\n";
    exit 1;
}

chdir($cwd);

require "$R_HOME/etc/Rdconvlib.pl";

@knownoptions = ("debug|d", "type|t:s", "h|help", "v|version",
		 "os|OS:s");
GetOptions (@knownoptions) || &usage();
&version() if $opt_v;
&usage() if $opt_h;

$OSdir = $opt_os if $opt_os;

usage() if $opt_help;
print stderr "R_HOME: '$R_HOME';  cwd='$cwd'\n" if $opt_debug;

##-- In the future, we want allow  SEVERAL types simultaneously ... :
if($opt_type =~ /html/i){
    Rdconv($ARGV[0],$opt_type,$opt_debug, 0);# filename 0 : STDOUT
}
elsif($opt_type =~ /txt/i){
    Rdconv($ARGV[0],$opt_type,$opt_debug, 0);
}
elsif($opt_type =~ /Sd/i){
    Rdconv($ARGV[0],$opt_type,$opt_debug, 0);
}
elsif($opt_type =~ /latex/i){
    Rdconv($ARGV[0],$opt_type,$opt_debug, 0);
}
else {
    Rdconv($ARGV[0],$opt_type,$opt_debug, 0, -1);
}

### Local Variables: ***
### mode: perl ***
### End: ***
__END__
:endofperl
