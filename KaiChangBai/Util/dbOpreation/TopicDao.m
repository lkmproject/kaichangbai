//
//  TopicDao.m
//  KaiChangBai
//
//  Created by app-pot on 26/12/12.
//
//

#import "TopicDao.h"
#import "Topic.h"
static TopicDao *gSharedInstance = nil;

@implementation TopicDao

- (void)dealloc
{
    gSharedInstance = nil;
    [self.dbQueue close];
}

+(TopicDao *)sharedInstance
{
    @synchronized(self)
    {
        if (gSharedInstance == nil)
			gSharedInstance = [[TopicDao alloc] init];
    }
    return gSharedInstance;
}

-(NSString *)setTable:(NSString *)sql{
    return [NSString stringWithFormat:sql,  K_DBTable_Topic];
}

-(void)insertOrUpdateWithObj:(Topic*)obj
{
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:[self setTable:@"DELETE FROM %@ WHERE TopicID = ?"],obj.strTopicId];
        [db executeUpdate:[self setTable:@"INSERT INTO %@ (TopicID, CategoryID, CreatedAt, Own, Recommend, Title, UpdatedAt, Body) VALUES (?,?,?,?,?,?,?,?)"], obj.strTopicId, obj.strCategoryId, obj.strCreateAt, obj.strOwn, obj.strRecommend, obj.strTitle, obj.strUpdatedAt, obj.strBodyJsonFormat];
    }];
}

- (Topic *)rsToObj:(FMResultSet*)rs
{
    __autoreleasing Topic *topic = [[Topic alloc] init];
    topic.strTopicId = [rs stringForColumn:@"TopicID"];
    topic.strCategoryId = [rs stringForColumn:@"CategoryID"];
    topic.strCreateAt = [rs stringForColumn:@"CreatedAt"];
    topic.strOwn = [rs stringForColumn:@"Own"];
    topic.strRecommend = [rs stringForColumn:@"Recommend"];
    topic.strTitle = [rs stringForColumn:@"Title"];
    topic.strUpdatedAt = [rs stringForColumn:@"UpdatedAt"];
    topic.strBodyJsonFormat = [rs stringForColumn:@"Body"];
    return topic;
}

// SELECT
-(NSMutableArray *)getAllResult:(NSString*)categoryID{
    __autoreleasing NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    [self.dbQueue inDatabase:^(FMDatabase *db)   {
        FMResultSet *rs = [db executeQuery:[self setTable:@"SELECT * FROM %@ WHERE CategoryID = ? ORDER BY UpdatedAt DESC"],categoryID];
        while ([rs next])
        {
            [result addObject:[self rsToObj :rs]];
        }
        [rs close];
    }];
    return result;
}


@end
