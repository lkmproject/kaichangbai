//
//  UILabel+Extension.h
//  KaiChangBai
//
//  Created by app-pot on 1/1/13.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

- (void)setDynamicHeight:(CGPoint)origin width:(int)width;

- (CGFloat)getLabelHeight;

- (CGPoint)getLastTextCoordinate;

- (CGFloat)getLabelWidth;
@end
