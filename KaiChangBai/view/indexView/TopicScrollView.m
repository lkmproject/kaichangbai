//
//  TopicScrollView.m
//  KaiChangBai
//
//  Created by app-pot on 26/2/13.
//
//

#import "TopicScrollView.h"
#import "UIImageView+WebCache.h"

//model
#import "IndexAdvertising.h"

//lib
#import "SVWebViewController.h"

@implementation TopicScrollView

- (id)initWithFrame:(CGRect)frame imageArr:(NSArray*)imageArray navViewController:(UINavigationController*)navController
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        arrPhotoInfo = [imageArray copy];
        navController_ = navController;
        
        myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [myScrollView setContentSize:CGSizeMake(320*arrPhotoInfo.count, 150)];
        myScrollView.delegate = self;
        myScrollView.pagingEnabled = YES;
        myScrollView.showsHorizontalScrollIndicator = NO;
        
        for (int i=0; i < arrPhotoInfo.count; i++)
        {
            IndexAdvertising *object = [[IndexAdvertising alloc] init:[arrPhotoInfo objectAtIndex:i]];
            
            UIButton *btnPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnPhoto addTarget:self
                         action:@selector(actButtonClick:)
               forControlEvents:UIControlEventTouchDown];
            
            UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
            NSURL *url = [NSURL URLWithString:object.strPhotoPath];
            [photo setImageWithURL:url];
            [btnPhoto addSubview:photo];
            btnPhoto.frame = CGRectMake(i*320, 0, photo.frame.size.width, photo.frame.size.height);
            [btnPhoto setTag:i];
            [myScrollView addSubview:btnPhoto];

        }
              
        [self addSubview:myScrollView];
        
        
        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
        viewBG.backgroundColor = [UIColor lightGrayColor];
        [viewBG setAlpha:0.45];
        [self addSubview:viewBG];
        
        pageControl = [[UIPageControl alloc] init];
        pageControl.frame = CGRectMake(0, viewBG.frame.origin.y, viewBG.frame.size.width, viewBG.frame.size.height);
        pageControl.numberOfPages = arrPhotoInfo.count;
        pageControl.currentPage = 0;
        [self addSubview:pageControl];
    }
    return self;
}


- (void)actButtonClick:(id)sender
{
    IndexAdvertising *object = [[IndexAdvertising alloc] init:[arrPhotoInfo objectAtIndex:[sender tag]]];
    NSURL *URL = [NSURL URLWithString:object.strLink];

    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
    webViewController.barsTintColor = [UIColor blackColor];
    [navController_ pushViewController:webViewController animated:YES];
}


#pragma mark - UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
     int currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
     pageControl.currentPage = currentPage;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
