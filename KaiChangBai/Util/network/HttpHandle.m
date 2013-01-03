//
//  HttpHandle.m
//  KaiChangBai
//
//  Created by app-pot on 3/1/13.
//
//

#import "HttpHandle.h"

//category
#import "NSObject+HttpCallback.h"

//vendor
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "SVProgressHUD.h"
#import "JSONKit.h"
#import "MTStatusBarOverlay.h"

//db
#import "CategoryDao.h"
#import "TopicDao.h"

//model
#import "Category.h"
#import "Topic.h"



@implementation HttpHandle
@synthesize delegate = _delegate;
- (void)downloadData
{
    
    if (!networkQueue) {
		networkQueue = [[ASINetworkQueue alloc] init];
	}
    [networkQueue reset];
    networkQueue.requestDidFinishSelector = @selector(dataComplete:);
    networkQueue.requestDidFailSelector = @selector(dataFailed:);
    networkQueue.queueDidFinishSelector = @selector(queueComplete:);
	[networkQueue setDelegate:self];
    
    //下载开场白数据
    NSMutableArray *arrIsExistData = [[CategoryDao sharedInstance] getAllResult];
    NSString *strUrl;
    if (arrIsExistData.count==0)
    {
        strUrl = @"http://test.easy17.com:4002/mobiles.json";
    }else
    {
        int latestTime = [[CategoryDao sharedInstance] getLatestDate];
        strUrl = [NSString stringWithFormat:@"http://test.easy17.com:4002/mobiles.json?last_updated_time=%i",latestTime];
    }
    
    ASIHTTPRequest *request;
    request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:strUrl]];
    request.username = K_key_data;
    [networkQueue addOperation:request];
    
    //下载开场白广告
    strUrl = @"http://www.easy17.com:4002/mobiles/ad.json";
    request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:strUrl]];
    request.username = k_key_advertising;
    [networkQueue addOperation:request];
    
    [networkQueue go];
    
}


#pragma mark - httpDelegate
- (void)dataComplete:(ASIHTTPRequest *)request
{
    if ([request.username isEqualToString:K_key_data])
    {
        NSString *response = [request responseString];
        NSDictionary* dic = [response objectFromJSONString];
        
        int iUpdateCount = 0;
        if ([dic objectForKey:@"success"])
        {
            NSArray *arrObjs = [dic objectForKey:@"result"];
            for (NSDictionary*dic in arrObjs)
            {
                Category *obj = [[Category alloc] init:dic];
                [[CategoryDao sharedInstance] insertOrUpdateWithObj:obj];
                
                NSArray *topics = [dic objectForKey:@"topics"];
                for (NSDictionary *topic in topics)
                {
                    Topic *topObj = [[Topic alloc] init:topic];
                    [[TopicDao sharedInstance] insertOrUpdateWithObj:topObj];
                    iUpdateCount++;
                }
            }// end for loop
            
            //显示有都少条topic更新
            NSString *strMessage = [NSString stringWithFormat:@"有%i条开场信息更新了",iUpdateCount];
            [[MTStatusBarOverlay sharedOverlay] postMessage:strMessage duration:3.5];
            
        }//END DIC IF
    }//END K_KEY_DATA IF
    
    
    if ([request.username isEqualToString:k_key_advertising])
    {
        NSString *response = [request responseString];
        NSDictionary* dic = [response objectFromJSONString];
        if ([dic objectForKey:@"success"])
        {
            NSUserDefaults *advertising = [NSUserDefaults
                                           standardUserDefaults];
            NSDictionary *dicResult = [dic objectForKey:@"result"];
            
            [advertising setObject:[NSKeyedArchiver archivedDataWithRootObject:dicResult] forKey:k_key_advertising];
            
            [advertising synchronize];
        }//END DIC IF
    }//END K_KEY_DATA IF

}

- (void)cancelAllHttpRequest
{
    [networkQueue cancelAllOperations];
}

- (void)dataFailed:(ASIHTTPRequest *)request
{
    if ([request.username isEqualToString:K_key_data])
    {
        [[MTStatusBarOverlay sharedOverlay] postMessage:@"数据更新失败" duration:1.5];
    }
    [self.delegate httpRequestFail];
}

- (void)queueComplete:(ASINetworkQueue *)queue
{
    [self.delegate httpRequestFinish];
}


@end
