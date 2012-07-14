//
//  LibiAuditor
//
//  Created by Dominic Chell on 13/02/2012.
//  Copyright (c) 2012 MDSec Consulting Ltd. All rights reserved.
//

#import "issues.h"

@implementation issues

+(void)list:(NSString *)dbPath;
{
    sqlite3 * iaDatabase;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: dbPath ] == YES)
    {
        const char *dbpath = [dbPath UTF8String];
        if (sqlite3_open(dbpath, &iaDatabase) == SQLITE_OK)
        {
            const char *sql_stmt = "SELECT name,description FROM ISSUES";
            sqlite3_stmt *detailStmt;
            if (sqlite3_prepare_v2(iaDatabase,sql_stmt,-1,&detailStmt,NULL)==SQLITE_OK) 
            {           
                int i=0;
                while(sqlite3_step(detailStmt) == SQLITE_ROW) 
                {
                    printf("\t\e[31mIssue %d:\e[37m %s\n\tDescription: %s\n",i, (char *)sqlite3_column_text(detailStmt,0), (char *)sqlite3_column_text(detailStmt,1));
                    i++;
                }
            }
            else printf("ERROR: Unable to execute SQL");
        
            sqlite3_close(iaDatabase);
        } else {
            printf("ERROR: Unable to open iAuditor database");
        }
    }
}

@end
