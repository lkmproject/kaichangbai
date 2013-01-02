//
//  TopicDao.h
//  KaiChangBai
//
//  Created by app-pot on 26/12/12.
//
//

#import "BaseDao.h"
@class Topic;
@interface TopicDao : BaseDao
+(TopicDao *)sharedInstance;
-(void)insertOrUpdateWithObj:(Topic*)obj;
-(NSMutableArray *)getAllResult:(NSString*)categoryID;

@end
