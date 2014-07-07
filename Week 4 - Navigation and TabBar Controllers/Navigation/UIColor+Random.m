//
//  UIColor+Random.m
//  Navigation
//
//  Created by Brendan Lee on 7/6/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import "UIColor+Random.h"

//This is a category. Categories add methods to objects that already exist. You can add functionality to objects that you don't even have the source to, in this case we added it to UIKit's closed-source UIColor object.

@implementation UIColor (Random)

+(UIColor*)randomColor
{
    float red = (arc4random() % 255)/255.0;
    float green = (arc4random() % 255)/255.0;
    float blue = (arc4random() % 255)/255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
