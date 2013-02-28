//
//  DetailViewAdvertising.m
//  KaiChangBai
//
//  Created by app-pot on 28/2/13.
//
//

#import "DetailViewAdvertising.h"
#import "HttpHandle.h"
#import "UIImageView+WebCache.h"
#import "SVWebViewController.h"
@implementation DetailViewAdvertising

- (id)initWithFrame:(CGRect)frame andViewController:(UINavigationController *)navController
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        navController_ = navController;
        NSUserDefaults *userData = [NSUserDefaults
                                    standardUserDefaults];
        NSData *data = [userData objectForKey:k_key_advertising];
        if (userData != nil)
        {
           NSDictionary* dicAdvertising = [NSKeyedUnarchiver
                              unarchiveObjectWithData:data];
            
           if (dicAdvertising)
            {
                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 526)];
                NSURL *url =[NSURL URLWithString:[dicAdvertising objectForKey:@"image"]];
                strLink_ = [dicAdvertising objectForKey:@"url"];
                [image setImageWithURL:url];
                
                UIButton *btnPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
                [btnPhoto addTarget:self
                             action:@selector(actButtonClick:)
                   forControlEvents:UIControlEventTouchDown];

                [btnPhoto addSubview:image];
                btnPhoto.frame = CGRectMake(0, 0, image.frame.size.width, image.frame.size.height);

                
                UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
                [scrollview addSubview:btnPhoto];
                scrollview.contentSize = CGSizeMake(frame.size.width, image.frame.size.height);
                [self addSubview:scrollview];
            }

        }else
        {
            return nil;
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)actButtonClick:(id)sender
{
    
    NSURL *URL = [NSURL URLWithString:strLink_];
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
    webViewController.barsTintColor = [UIColor blackColor];
    [navController_ pushViewController:webViewController animated:YES];

}

@end
