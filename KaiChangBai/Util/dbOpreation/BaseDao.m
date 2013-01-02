//
//  BaseDao.m
//  KaiChangBai
//
//  Created by app-pot on 25/12/12.
//
//

#import "BaseDao.h"
@implementation BaseDao
@synthesize dbFile;
@synthesize dbQueue;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.dbFile = [DbFileManager dbFilePath];
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbFile];
    }
    return  self;
}

-(NSString *)setTable:(NSString *)sql
{
    return nil;
}


@end
