//
//  Category.m
//  KaiChangBai
//
//  Created by app-pot on 21/12/12.
//
//

#import "Category.h"
#import "JSONKit.h"
@implementation Category
@synthesize strCategoryId,strName;
@synthesize iUpdatedAt;


- (id)init:(NSDictionary*)dic
{
    self = [super init];
    if (self)
    {
        self.strCategoryId = [dic objectForKey:@"_id"];
        self.strName = [dic objectForKey:@"name"];
        self.iUpdatedAt = [[dic objectForKey:@"updated_at"] intValue];
    }
    return self;
}


- (NSString*)getIndex
{
    return self.strCategoryId;
}

@end
