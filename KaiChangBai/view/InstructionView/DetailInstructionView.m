//
//  DetailInstructionView.m
//  KaiChangBai
//
//  Created by app-pot on 28/2/13.
//
//

#import "DetailInstructionView.h"

@implementation DetailInstructionView

- (id)initWithFrame:(CGRect)frame andUIScrollView:(UIScrollView*)scrollview{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        scrollView_ = scrollview;
        UIView *instructionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [instructionView setBackgroundColor:[UIColor lightTextColor]];
        UIImageView *imageInstruction = [[UIImageView alloc] initWithFrame:CGRectMake(65, 80, 200, 200)];
        [imageInstruction setImage:[UIImage imageNamed:@"Instruction"]];
        [instructionView addSubview:imageInstruction];
        [self addSubview:instructionView];
        
        
        UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                             action:@selector(swipeDetected:)];
        swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeRecognizer];
        
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

- (void)swipeDetected:(UIGestureRecognizer *)sender {
   
    if (scrollView_.contentSize.width>320)
    {
        CGRect rc = [scrollView_ bounds];
        rc.origin.x = 320 ;
        rc.origin.y = 0 ;
        [scrollView_ scrollRectToVisible:rc animated:YES];

    }
     [self removeFromSuperview];
}

@end
