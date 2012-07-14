
README

iAuditorcli version 0.1 beta (14/07/2012):
===========================================

iAuditorcli is the command line component of iAuditor, a semi-automated tool for assessing iOS applications.

This application is dependent upon MobileSubstrate. The application works by installing hooks on various APIs, interpreting the arguments and reacting accordingly.

Usage:

[*] iAuditor v0.1 Help

Commands:
	help                        - This help
	list                        - Lists the installed applications
	scan "appnumber" or "all"   - Performs binary assurance checks
	audit "appnumber"           - Enables auditing on the application
	issues "appnumber"          - Prints the current list of issues to the console
	clean                       - Disables all auditing
	exit                        - Quits iAuditor


Further information on MobileSubstrate can be found in [1].

Author: Dominic Chell, MDSec Consulting Ltd
Contact: research@mdsec.co.uk

[1] http://iphonedevwiki.net/index.php/MobileSubstrate

