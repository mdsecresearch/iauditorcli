//
//  LibiAuditor
//
//  Created by Dominic Chell on 13/02/2012.
//  Copyright (c) 2012 MDSec Consulting Ltd. All rights reserved.
//
#import <Foundation/Foundation.h>
#define IAUDITORPLIST @"/Library/MobileSubstrate/DynamicLibraries/LibiAuditor.plist"

@interface iauditorDB : NSObject
+(void) cleanPlist;
+(void) addAppToPlist:(NSString *)bundle;
@end
