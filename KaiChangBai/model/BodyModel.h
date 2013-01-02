//
//  BodyModel.h
//  KaiChangBai
//
//  Created by app-pot on 1/1/13.
//
//

#import <Foundation/Foundation.h>

@interface BodyModel : NSObject
{
    NSString *strGender;
    NSString *strBody;
}

@property (nonatomic,copy) NSString *strGender;
@property (nonatomic,copy) NSString *strBody;

- (id)init:(NSDictionary*)dic;


@end
