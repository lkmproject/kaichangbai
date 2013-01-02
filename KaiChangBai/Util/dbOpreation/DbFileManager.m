//
//  DbFileManager.m
//
//  Created by fox wang on 12-3-23.
//

#import "DbFileManager.h"


@implementation DbFileManager
+ (NSString *)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (void)checkWithCreateDbFile:(NSString *)fullPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSString *dbFileName = k_DB_Name;
    BOOL found = [fileManager fileExistsAtPath:fullPath];
    if(!found)
    {
        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
        NSString *defaultDBFilePath =
        [resourcePath stringByAppendingPathComponent:dbFileName];
        
        found = [fileManager copyItemAtPath:defaultDBFilePath
                                     toPath:fullPath
                                      error:&error];
        if (!found)
        {
            NSAssert1(0,
                      @"创建数据库失败 '%@'.",
                      [error localizedDescription]);
        }
    }
}

+ (NSString *)dbFilePath
{
    NSString *dbFileName = k_DB_Name;
    NSString *documentsDirectory = [DbFileManager documentPath];
    
    NSString *dbFilePath =
    [documentsDirectory stringByAppendingPathComponent:dbFileName];
    
    [DbFileManager checkWithCreateDbFile:dbFilePath];
    
    return dbFilePath;
}

+ (BOOL)createFolderInDocment:(NSString *)folderName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [DbFileManager documentPath];
    NSString *foldFullPath =  [documentsDirectory stringByAppendingPathComponent:folderName];
    return [fileManager createDirectoryAtPath:foldFullPath withIntermediateDirectories:YES attributes:nil error:nil];
}

@end
