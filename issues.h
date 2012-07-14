//
//  LibiAuditor
//
//  Created by Dominic Chell on 13/02/2012.
//  Copyright (c) 2012 MDSec Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface issues : NSObject
+(void)list:(NSString *)dbPath;
@end
