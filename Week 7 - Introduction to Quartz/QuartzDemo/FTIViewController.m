//
//  FTIViewController.m
//  QuartzDemo
//
//  Created by Brendan Lee on 8/3/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import "FTIViewController.h"
#import "FTILiveCircleGrid.h"

@interface FTIViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet FTILiveCircleGrid *liveCircleView;

@end

@implementation FTIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _mainImageView.image = [self circleGridWithSize:_mainImageView.bounds.size circleSize:CGSizeMake(20, 20) circleColor:[UIColor blueColor] spacing:5.0];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self animationDemo];
    //[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(resizeImages) userInfo:nil repeats:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)resizeImages
{
    _mainImageView.frame = CGRectMake(0, 0, self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0);
    _liveCircleView.frame = CGRectMake(0, self.view.bounds.size.height / 2.0, self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0);
}

-(void)animationDemo
{
    [UIView animateWithDuration:1.0
                          delay:0.0 options:0
                     animations:^{
                         _mainImageView.frame = CGRectMake(0, 0, self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0);
                         _liveCircleView.frame = CGRectMake(0, self.view.bounds.size.height / 2.0, self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0);
                     } completion:^(BOOL finished) {
                         [_liveCircleView setNeedsDisplay];
                     }];
}

- (UIImage*)circleGridWithSize:(CGSize)size circleSize:(CGSize)circleSize circleColor:(UIColor*)circleColor spacing:(float)spacing
{
    UIGraphicsBeginImageContextWithOptions(size, YES, [[UIScreen mainScreen] scale]); //For every open, there must be a close. Be careful not to return an image before you close the context.
    
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
    
    UIImage * imageToReturn = UIGraphicsGetImageFromCurrentImageContext()
    ;

    UIGraphicsEndImageContext();
    
    return imageToReturn;
}


@end
