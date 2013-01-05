//
//  AboutUsViewController.m
//  KaiChangBai
//
//  Created by app-pot on 5/1/13.
//
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
    
    [self setTitle:@"关于我们"];
    
	UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, gViewWidth, gViewHeight)];
    
    NSURL *url = [NSURL URLWithString:@"http://www.easy17.com/about.html"];
    NSURLRequest *newURLRequest = [[NSURLRequest alloc] initWithURL: url];
    [webView loadRequest:newURLRequest];
    
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
