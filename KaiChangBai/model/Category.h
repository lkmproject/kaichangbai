//
//  Category.h
//  KaiChangBai
//
//  Created by app-pot on 21/12/12.
//
//

#import <Foundation/Foundation.h>

@interface Category : NSObject
{
    int iUpdatedAt;
    NSString *strCategoryId;
    NSString *strName;
}

@property(nonatomic,copy)NSString *strCategoryId;
@property(nonatomic,copy)NSString *strName;
@property(nonatomic,assign)int iUpdatedAt;

- (id)init:(NSDictionary*)dic;
- (NSString*)getIndex;

@end
