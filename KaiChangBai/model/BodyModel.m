//
//  BodyModel.m
//  KaiChangBai
//
//  Created by app-pot on 1/1/13.
//
//

#import "BodyModel.h"

@implementation BodyModel
@synthesize strBody,strGender;
- (id)init:(NSDictionary*)dic
{
    self = [super init];
    if (self)
    {
        self.strGender = [dic objectForKey:@"gender"];
        self.strBody = [dic objectForKey:@"body"];
 
    }
    return self;

}


@end
