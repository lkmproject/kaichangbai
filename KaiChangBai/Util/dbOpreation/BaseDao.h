//
//  BaseDao.h
//  KaiChangBai
//
//  Created by app-pot on 25/12/12.
//
//


#import <Foundation/Foundation.h>

#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"

#import "DbFileManager.h"
@interface BaseDao : NSObject
{
    NSString *dbFile;
    
    FMDatabaseQueue *dbQueue;
}

@property (nonatomic , copy) NSString *dbFile;
@property (nonatomic, retain)FMDatabaseQueue *dbQueue;

-(NSString *)setTable:(NSString *)sql;

@end
