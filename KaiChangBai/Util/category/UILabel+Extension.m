//
//  UILabel+Extension.m
//  KaiChangBai
//
//  Created by app-pot on 1/1/13.
//
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (void)setDynamicHeight:(CGPoint)origin width:(int)width
{
    [self setLineBreakMode:UILineBreakModeWordWrap];
    [self setMinimumFontSize:self.font.pointSize];
    [self setNumberOfLines:0];
    CGSize constraint = CGSizeMake(width , MAXFLOAT);
    
    CGSize size = [self.text sizeWithFont:[UIFont systemFontOfSize:self.font.pointSize] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    
    [self setFrame:CGRectMake(origin.x, origin.y,
                              width, size.height)];
    

}

- (CGSize)getLabelSize
{
    
    CGSize constraint = CGSizeMake(self.frame.size.width , MAXFLOAT);
    
    CGSize size = [self.text sizeWithFont:[UIFont systemFontOfSize:self.font.pointSize] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    return size;

}

- (CGFloat)getLabelHeight
{
    return [self getLabelSize].height;
}

- (CGFloat)getLabelWidth
{
    
    return [self getLabelSize].width;
}

- (CGPoint)getLastTextCoordinate
{
    CGSize sz = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
    
    CGSize linesSz = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    if(sz.width <= linesSz.width) //判断是否折行
        
    {
        
        return  CGPointMake(self.frame.origin.x + sz.width, self.frame.origin.y);
        
    }

    return  CGPointMake(self.frame.origin.x + (int)sz.width % (int)linesSz.width,linesSz.height - sz.height/2);
}


@end
