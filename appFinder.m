//
//  LibiAuditor
//
//  Created by Dominic Chell on 13/02/2012.
//  Copyright (c) 2012 MDSec Consulting Ltd. All rights reserved.
//

#import "appFinder.h"
#import "AppDB.h"

@implementation appFinder

+(NSMutableArray *) getAppList
{
	static NSString *const cacheFileName = @"com.apple.mobile.installation.plist";
	NSString *relativeCachePath = [[@"Library" stringByAppendingPathComponent: @"Caches"] stringByAppendingPathComponent: cacheFileName];
	NSDictionary *cacheDict = nil;
	NSString *path = nil;
    
	for (short i = 0; 1; i++)
	{
        
		switch (i) {
            case 0:
                path = [NSHomeDirectory() stringByAppendingPathComponent: relativeCachePath];
                break;
            case 1:
                path = [[NSHomeDirectory() stringByAppendingPathComponent: @"../.."] stringByAppendingPathComponent: relativeCachePath];
                break;
            case 2:
                path = [@"/var/mobile" stringByAppendingPathComponent: relativeCachePath];
                break;
            default:
                break;
        }
		
		BOOL isDir = NO;
		if ([[NSFileManager defaultManager] fileExistsAtPath: path isDirectory: &isDir] && !isDir)
			cacheDict = [NSDictionary dictionaryWithContentsOfFile: path];
		
		if (cacheDict)
			break;
	}
	
    NSMutableArray *appList = [[NSMutableArray alloc] init];
    NSDictionary *user = [cacheDict objectForKey: @"User"];
	for(NSDictionary *key in user)
    {
        AppDB *appDB = [[AppDB alloc] init];
        [appDB setPath:[[user objectForKey:key] valueForKey:@"Path"]];
        [appDB setName:[[user objectForKey:key] valueForKey:@"CFBundleExecutable"]];
        [appDB setBundle:[[user objectForKey:key] valueForKey:@"CFBundleIdentifier"]];
        [appList addObject:appDB];
    }
    
    return appList;
}
@end
