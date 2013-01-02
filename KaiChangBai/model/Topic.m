//
//  TopicModel.m
//  KaiChangBai
//
//  Created by app-pot on 21/12/12.
//
//

#import "Topic.h"

@implementation Topic
@synthesize strCategoryId,strBodyJsonFormat,strRecommend,strOwn,strCreateAt,strTitle,strTopicId,strUpdatedAt;

- (id)init:(NSDictionary*)dic
{
    self = [super init];
    if (self)
    {
        self.strTopicId = [dic objectForKey:@"_id"];
        self.strBodyJsonFormat = [dic objectForKey:@"body"];
        self.strCategoryId = [dic objectForKey:@"category_id"];
        self.strCreateAt = [dic objectForKey:@"created_at"];
        self.strOwn = [dic objectForKey:@"own"];
        self.strRecommend = [dic objectForKey:@"recommend"];
        self.strTitle = [dic objectForKey:@"title"];
        self.strUpdatedAt = [dic objectForKey:@"updated_at"];
    }
    return self;
}

- (NSString*)getIndex
{
    return self.strCategoryId;
}

@end
