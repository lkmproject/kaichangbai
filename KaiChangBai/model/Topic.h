//
//  TopicModel.h
//  KaiChangBai
//
//  Created by app-pot on 21/12/12.
//
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject
{
    NSString *strBodyJsonFormat;
    NSString *strCategoryId;
    NSString *strTopicId;
    NSString *strOwn;
    NSString *strRecommend;
    NSString *strTitle;
    NSString *strCreateAt;
    NSString *strUpdatedAt;
}
@property (nonatomic,copy)NSString *strBodyJsonFormat;
@property (nonatomic,copy)NSString *strCategoryId;
@property (nonatomic,copy)NSString *strTopicId;
@property (nonatomic,copy)NSString *strOwn;
@property (nonatomic,copy)NSString *strRecommend;
@property (nonatomic,copy)NSString *strTitle;
@property (nonatomic,copy)NSString *strCreateAt;
@property (nonatomic,copy)NSString *strUpdatedAt;


- (id)init:(NSDictionary*)dic;
- (NSString*)getIndex;


@end
