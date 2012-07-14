//
//  LibiAuditor
//
//  Created by Dominic Chell on 13/02/2012.
//  Copyright (c) 2012 MDSec Consulting Ltd. All rights reserved.
//
#import "iauditorDB.h"

@implementation iauditorDB

+(void) cleanPlist
{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:IAUDITORPLIST error:&error];
    
    NSMutableDictionary *iadbPlist = [NSMutableDictionary dictionary];
    NSMutableDictionary *filter = [NSMutableDictionary dictionary];
    [iadbPlist setObject:filter forKey:@"Filter"];
	[iadbPlist writeToFile:IAUDITORPLIST atomically:TRUE];
}

+(void) addAppToPlist:(NSString *)bundle;
{
    NSMutableDictionary *currentPList = [NSMutableDictionary dictionaryWithContentsOfFile:IAUDITORPLIST];
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:IAUDITORPLIST error:&error];
    
    NSMutableDictionary *filter = [currentPList objectForKey:@"Filter"];
    
    // if we don't have an existing bundles key in our dictionary
    if([filter objectForKey:@"Bundles"] == nil)
    {
        NSMutableArray *bundles = [[NSMutableArray alloc] init];
        [bundles addObject:bundle];
        [filter setObject:bundles forKey:@"Bundles"];
    }
    else {
        // otherwise use the existing bundle key
        NSMutableArray *bundles = [filter objectForKey:@"Bundles"];
        // check if the bundle already exists and add if not        
        if(![bundles containsObject:bundle]) [bundles addObject:bundle];
    }
    
    // add the filter dictionary
    [currentPList writeToFile:IAUDITORPLIST atomically:TRUE];
    
}

@end
