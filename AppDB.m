//
//  LibiAuditor
//
//  Created by Dominic Chell on 13/02/2012.
//  Copyright (c) 2012 MDSec Consulting Ltd. All rights reserved.
//

#import "AppDB.h"

@implementation AppDB

-(void) setPath:(NSString *)n;
{
    appPath = n;
}

-(NSString *) getPath;
{
    return appPath;
}

-(void) setName:(NSString *)n;
{
    appName = n;
}

-(NSString *) getName;
{
    return appName;
}


-(void) setBundle:(NSString *)n;
{
    appBundle = n;
}

-(NSString *) getBundle;
{
    return appBundle;
}

@end
