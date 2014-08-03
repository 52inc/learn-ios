//
//  FTILiveCircleGrid.m
//  QuartzDemo
//
//  Created by Brendan Lee on 8/3/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import "FTILiveCircleGrid.h"

@implementation FTILiveCircleGrid

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

// DO NOT ATTEMPT TO USE THIS FOR ANIMATION!

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    //This method is invoke by UIKit in the middle of its drawing subsystem. It is only invoked when your view needs a redraw. The system (or you) can decide when it needs to be redrawn. iOS runs at 60 frames per second, so redrawing your frame each time would be a terrible performance hit. UIKit will cache until its invalidated by size changes, layout changes, or manually.
    
    //Because UIKit already has an open rendering that you're drawing into, you don't need to create a CGContext like we did before. One already exists. Because it already exists, we can draw directly into it. This is why we removed the image returning feature from our method.
    
    [self circleGridWithSize:rect.size circleSize:CGSizeMake(20.0, 20.0) circleColor:[UIColor blueColor] spacing:5.0];
    
    //Again, we don't need to close the context. The system will continue rendering past us and our little view.
}

- (void)circleGridWithSize:(CGSize)size circleSize:(CGSize)circleSize circleColor:(UIColor*)circleColor spacing:(float)spacing
{
    //Don't need to create a new context, we're drawing into an existing one.
    
    //Specify the color for all types of drawing in the context
    [[UIColor whiteColor] set];
    
    //Set different colors for different types of drawing in the context
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor whiteColor].CGColor);
    
    //Fill the background color
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height));
    
    //Let's draw some circles!
    
    //Blue circles
    [circleColor set];
    
    int row = 0;
    int column = 0;
    
    //On iOS, the coordinate system origin for Quartz (and UIKit) is the top left corner. On Mac OS X, it's the bottom left corner.
    while (spacing + (row * (circleSize.height + spacing)) < size.height) {
        
        float Xorigin = spacing + (column * (circleSize.width + spacing));
        float Yorigin = spacing + (row * (circleSize.height + spacing));
        
        CGContextFillEllipseInRect(UIGraphicsGetCurrentContext(), CGRectMake(Xorigin, Yorigin, circleSize.width, circleSize.height));
        
        column++;
        
        if (spacing + (column * (circleSize.width + spacing)) > size.width) {
            column = 0;
            row++;
        }
    }
    
    //Let's draw a gray grid between the circles.
    //NOTE: In reality, its more efficient to do this inside the previous while loop. The fewer loops the better. But, for example purposes I've broken it out here as a seperate loop.
    
    [[UIColor lightGrayColor] set];
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0); // A lot of lines in the UI for iOS 7 are actually 1.0 pt on non-Retina devices, and 0.5 pt on Retina devices. If you want fine lines (when capable) you can use this as the value: (1.0/[[UIScreen mainScreen] scale])
    
    //We can calculate the required number of rows and columns
    int totalRows = (int)ceilf((size.height-spacing) / (circleSize.height + spacing));
    int totalColumns = (int)ceilf((size.width-spacing) / (circleSize.width + spacing));
    
    for (int i=1; i<= totalColumns || i <= totalRows; i++) {
        
        if (i < totalRows) {
            //Draw row
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0, spacing + (i * (circleSize.height + spacing)) - (spacing / 2.0)); //Subtract spacing/2 to get the mid point between circles
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), size.width, spacing + (i * (circleSize.height + spacing)) - (spacing / 2.0));
        }
        
        if (i < totalColumns) {
            //Draw column
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), spacing + (i * (circleSize.width + spacing)) - (spacing / 2.0), 0); //Subtract spacing/2 to get the mid point between circles
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), spacing + (i * (circleSize.width + spacing)) - (spacing / 2.0), size.height);
        }
        
        //These haven't been stroked yet! Just added to the context for rendering when you tell them stroke later.
    }
    
    //After the complete loop and adding all of our lines, we stroke the paths.
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    //Don't need to return an image or close the context
}
@end
