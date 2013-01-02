//
//  CategoryDao.h
//  KaiChangBai
//
//  Created by app-pot on 25/12/12.
//
//

#import "BaseDao.h"
@class Category;
@interface CategoryDao : BaseDao

+(CategoryDao *)sharedInstance;
-(void)insertOrUpdateWithObj:(Category*)obj;
-(NSMutableArray *)getAllResult;
-(int)getLatestDate;

@end
