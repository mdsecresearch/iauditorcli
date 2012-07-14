//
//  LibiAuditor
//
//  Created by Dominic Chell on 13/02/2012.
//  Copyright (c) 2012 MDSec Consulting Ltd. All rights reserved.
//

#import "binScan.h"

@implementation binScan

+(BOOL)checkPIE:(NSString *)binPath
{
    const char *path = [binPath UTF8String];
    char *buffer[1];
    
    FILE *fp = fopen(path, "r");
    if(!fp)
        return false;
    
    fseek(fp, 0x1a, SEEK_SET);
    fread((char*)&buffer,1, sizeof(char), fp);
    
    if((int)buffer[0] == 0x20) return true;
    else return false;
}

@end
