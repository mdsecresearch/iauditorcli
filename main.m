//
//  LibiAuditor
//
//  Created by Dominic Chell on 13/02/2012.
//  Copyright (c) 2012 MDSec Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "appFinder.h"
#import "AppDB.h"
#import "binScan.h"
#import "iauditorDB.h"
#import "issues.h"

#define BUFFER_SIZE 512
#define showHelp() { printf("[*] iAuditor v0.1 Help\n\nCommands:\n\thelp\t\t\t\t- This help\n\tlist\t\t\t\t- Lists the installed applications\n\tscan \"appnumber\" or \"all\"\t- Performs binary assurance checks\n\taudit \"appnumber\"\t\t- Enables auditing on the application\n\tissues \"appnumber\"\t\t- Prints the current list of issues to the console\n\tclean\t\t\t\t- Disables all auditing\n\texit\t\t\t\t- Quits iAuditor");}

int main (int argc, const char * argv[])
{

    @autoreleasepool
    {	
        NSMutableArray *listOfInstalledApps = [[NSMutableArray alloc] init];
        listOfInstalledApps = [appFinder getAppList];   

        [iauditorDB cleanPlist];

    	NSMutableString *cmd = [NSMutableString stringWithString:@""];
        
        BOOL done = NO;
        char raw[BUFFER_SIZE];
        uint8_t i;
        int c;
        
        raw[BUFFER_SIZE - 1] = 0;
        while(1)
        {
            cmd = [NSMutableString stringWithString:@""];
            
            printf("\niauditor>");
            while(true) {
                for(i = 0; i < BUFFER_SIZE - 1; ++i) if((done = ((c = getc(stdin)) == EOF || (raw[i] = c) == '\n'))) break;
                
                if(done) raw[i] = 0;
                [cmd appendFormat:@"%s", raw];
                if(done) break;
            }
            
            NSArray *command = [cmd componentsSeparatedByString:@" "];
            if([[command objectAtIndex:0] isEqualToString: @"help"])
            {
                showHelp();
            }
            else if([[command objectAtIndex:0] isEqualToString: @"list"])
            {
                printf("[*] Printing list of Apps\n\n");
                int i=0;
                for(AppDB *adb in listOfInstalledApps)
                {
                    printf("%d.\t%s\n",i, [[adb getName] UTF8String]);
                    i++;
                }
            }
            else if(([[command objectAtIndex:0] isEqualToString: @"scan"]))
            {
                printf("[*] Performing binary assurance checks against application\n");
                if([command count] < 2)
                    printf("ERROR: Unable to read app number from command line");
                else if([[command objectAtIndex:1] isEqualToString:@"all"])
                {
                    for(AppDB *adb in listOfInstalledApps)
                    {
                        NSString *binpath = [NSString  stringWithFormat:@"\"%@/%@\"", [adb getPath], [adb getName]];
                        if([binScan checkPIE: binpath])
                            printf("Position Independent Executable (PIE) is ENABLED on %s\n", [[adb getName] UTF8String]);
                        else printf("WARNING: Position Independent Executable (PIE) is DISABLED on on %s\n", [[adb getName] UTF8String]);
                    }
                }
                else
                {
                    NSUInteger index = [[command objectAtIndex:1] integerValue];
                    AppDB *selectedApp = [listOfInstalledApps objectAtIndex:index];
                    NSString *binpath = [NSString  stringWithFormat:@"\"%@/%@\"", [selectedApp getPath], [selectedApp getName]];
                    
                    if([binScan checkPIE: binpath])
                        printf("Position Independent Executable (PIE) is ENABLED on %s", [[selectedApp getName] UTF8String]);
                    else printf("WARNING: Position Independent Executable (PIE) is DISABLED on %s", [[selectedApp getName] UTF8String]);
                }
            }
            else if(([[command objectAtIndex:0] isEqualToString: @"audit"]))
            {
                if([command count]<2)
                    printf("ERROR: Unable to read app number form command line");
                else
                {
                    NSUInteger index = [[command objectAtIndex:1] integerValue];
                    AppDB *selectedApp = [listOfInstalledApps objectAtIndex:index];
                    [iauditorDB addAppToPlist:[selectedApp getBundle]];
                    printf("[*] Auditing ENABLED on %s, now go use the app!", [[selectedApp getName] UTF8String]);
                }
            }
            else if(([[command objectAtIndex:0] isEqualToString: @"issues"]))
            {
                if([command count]<2)
                    printf("ERROR: Unable to read app number form command line");
                else
                {
                    NSUInteger index = [[command objectAtIndex:1] integerValue];
                    AppDB *selectedApp = [listOfInstalledApps objectAtIndex:index];
                    printf("[*] Listing issues for %s:\n", [[selectedApp getName] UTF8String]);
                    NSString *iadbPath = [NSString stringWithFormat:@"%@/../Documents/iauditor.db", [selectedApp getPath]];
                    [issues list:iadbPath];                
                }
            }
            else if(([[command objectAtIndex:0] isEqualToString: @"clean"]))
            {
                printf("[*] Disabling all auditing!");
                [iauditorDB cleanPlist];
            }
            else if([[command objectAtIndex:0] isEqualToString: @"exit"])
            {
                printf("[*] Exit command received, exiting!\n");
                exit(1);
            }
        }// end while 1
    }// end autorelease
	return 0;
}

