//
//  UIScrollView+Sharp.m
//  iOSLib
//
//  Created by Sommer, Martin on 28.02.13.
//  Copyright (c) 2013 Sommer, Martin. All rights reserved.
//

#import "UIScrollView+Sharp.h"

@implementation UIScrollView (Sharp)

-(void)stopScrolling
{
    //Stop the scrolling in a UIScrollView by telling the view to scroll to its current offset position
    //(or to scroll to the edge of the view if the current offset position is outside of the content
    //area due to a "bounce")
    
    float currentX = self.contentOffset.x;
    float minX = 0;
    float maxX = fmax(0, self.contentSize.width - self.frame.size.width);
    
    float currentY = self.contentOffset.y;
    float minY = 0;
    float maxY = fmax(0, self.contentSize.height - self.frame.size.height);
    
    float x = fmin(fmax(minX, currentX), maxX);
    float y = fmin(fmax(minY, currentY), maxY);
    
    //Tell the view to scroll to the new position. Note that animated must be YES in order to stop
    //any current scrolling animations.
    [self setContentOffset:CGPointMake(x, y) animated:YES];
}

@end
