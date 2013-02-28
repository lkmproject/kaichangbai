//
//  IndexAdvertising.h
//  KaiChangBai
//
//  Created by app-pot on 26/2/13.
//
//

#import <Foundation/Foundation.h>

@interface IndexAdvertising : NSObject
{
    NSString *strPhotoPath;
    NSString *strLink;
}

@property(nonatomic,strong)NSString *strPhotoPath;
@property(nonatomic,strong)NSString *strLink;

- (id)init:(NSDictionary*)dic;

@end
