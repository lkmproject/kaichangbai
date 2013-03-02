//
//  SettingViewController.m
//  KaiChangBai
//
//  Created by app-pot on 5/1/13.
//
//

#import "SettingViewController.h"
#import "AboutUsViewController.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:254/255.0 green:1 blue:249/255.0 alpha:1];
    self.navigationItem.titleView = [self setTitleView:@"设置" iconPositionX:44];
    
    
    UIImageView *imageHead = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 138)];
    [imageHead setImage:[UIImage imageNamed:@"userSetting"]];
    [self.view addSubview:imageHead];
    
    UILabel *labVersion = [[UILabel alloc] initWithFrame:CGRectMake(0, imageHead.frame.size.height+15, 320, 30)];
    labVersion.backgroundColor = [UIColor clearColor];
    labVersion.textAlignment = UITextAlignmentCenter;
    labVersion.textColor = [UIColor colorWithRed:154/255.0 green:150/255.0 blue:138/255.0 alpha:1];
    labVersion.text = @"版本 1.1 Build 2012-03-01";
    [self.view addSubview:labVersion];
    
    UIButton *btnFeedback = [self addButtonToViewWithName:@"反馈" tag:100];
    [btnFeedback setFrame:CGRectMake(20, imageHead.frame.size.height+50, 279, 51)];


    UIButton *btnWeiBo = [self addButtonToViewWithName:@"微博" tag:101];
    [btnWeiBo setFrame:CGRectMake(20, btnFeedback.frame.origin.y+71, 279, 51)];
    
    
    UIButton *btnAboutUs = [self addButtonToViewWithName:@"关于我们" tag:102];
    [btnAboutUs setFrame:CGRectMake(20, btnWeiBo.frame.origin.y+71, 279, 51)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - local method
- (UIButton*)addButtonToViewWithName:(NSString*)title tag:(int)iTag
{
    __autoreleasing UIButton *btnSetting= [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSetting addTarget:self
                   action:@selector(actBtnPress:)
         forControlEvents:UIControlEventTouchDown];
    [btnSetting setTitle:title forState:UIControlStateNormal];
    btnSetting.tag = iTag;
    [btnSetting setBackgroundImage:[UIImage imageNamed:@"btnSettingNormal.png"] forState:UIControlStateNormal];
    [btnSetting setTitleColor:[UIColor colorWithRed:154/255.0 green:150/255.0 blue:138/255.0 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:btnSetting];
    return btnSetting;
}

- (void)actBtnPress:(id)sender
{
    int tag = [sender tag];
    switch (tag) {
        case 100:
        {
            [UMFeedback showFeedback:self withAppkey:UMENG_APPKEY];
        }
            break;
        case 101:
        {
            NSURL *URL = [NSURL URLWithString:@"http://weibo.com/kaichangbai1111"];
            SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
            webViewController.barsTintColor = [UIColor blackColor];
            [self.navigationController pushViewController:webViewController animated:YES];
             
        }
            break;
        case 102:
        {
            AboutUsViewController *aboutController = [[AboutUsViewController alloc] init];
            [self.navigationController pushViewController:aboutController animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
