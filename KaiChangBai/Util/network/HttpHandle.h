//
//  HttpHandle.h
//  KaiChangBai
//
//  Created by app-pot on 3/1/13.
//
//
#define K_key_data @"kaichangbaiData"
#define k_key_advertising @"kaichangbaiAdvertising"
#define k_key_indexAdvertising @"kaichangbaiIndexAdvertising"
#import <Foundation/Foundation.h>
@class ASINetworkQueue;
@interface HttpHandle : NSObject
{
     ASINetworkQueue *networkQueue;
}

@property(nonatomic,weak)id delegate;

- (void)downloadData;
- (void)cancelAllHttpRequest;

@end
