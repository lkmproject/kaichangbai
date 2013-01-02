//
//  CategoryDao.m
//  KaiChangBai
//
//  Created by app-pot on 25/12/12.
//
//

#import "CategoryDao.h"
#import "Category.h"

static CategoryDao *gSharedInstance = nil;

@implementation CategoryDao

- (void)dealloc
{
    gSharedInstance = nil;
    [self.dbQueue close];
}

+(CategoryDao *)sharedInstance
{
    @synchronized(self)
    {
        if (gSharedInstance == nil)
			gSharedInstance = [[CategoryDao alloc] init];
    }
    return gSharedInstance;
}

-(NSString *)setTable:(NSString *)sql{
    return [NSString stringWithFormat:sql,  K_DBTable_Category];
}

-(void)insertOrUpdateWithObj:(Category*)obj
{
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:[self setTable:@"DELETE FROM %@ WHERE CategoryID = ?"],obj.strCategoryId];
        [db executeUpdate:[self setTable:@"INSERT INTO %@ (CategoryID, Name, UpdatedAt) VALUES (?,?,?)"], obj.strCategoryId,obj.strName, [NSNumber numberWithInt:obj.iUpdatedAt]];
    }];
}

- (Category *)rsToObj:(FMResultSet*)rs
{
    __autoreleasing Category *category = [[Category alloc] init];
    category.strCategoryId = [rs stringForColumn:@"CategoryId"];
    category.strName = [rs stringForColumn:@"Name"];
    category.iUpdatedAt = [rs intForColumn:@"UpdatedAt"];
    return category;
}

// SELECT
-(NSMutableArray *)getAllResult{
   __autoreleasing NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    [self.dbQueue inDatabase:^(FMDatabase *db)   {
        FMResultSet *rs = [db executeQuery:[self setTable:@"SELECT * FROM %@ ORDER BY UpdatedAt DESC"]];
        while ([rs next])
        {
            [result addObject:[self rsToObj :rs]];
        }
        [rs close];
    }];
    return result;
}

-(int)getLatestDate
{
   NSMutableArray* array =  [self getAllResult];
   Category *category = (Category*)[array objectAtIndex:0];
   return category.iUpdatedAt;
}

@end
