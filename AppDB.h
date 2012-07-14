//
//  LibiAuditor
//
//  Created by Dominic Chell on 13/02/2012.
//  Copyright (c) 2012 MDSec Consulting Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface AppDB : NSObject
{
    NSString * appName;
    NSString * appPath;
    NSString * appBundle;
}

-(void) setPath:(NSString *)n;
-(NSString *) getPath;
-(void) setName:(NSString *)n;
-(NSString *) getName;
-(void) setBundle:(NSString *)n;
-(NSString *) getBundle;
@end
