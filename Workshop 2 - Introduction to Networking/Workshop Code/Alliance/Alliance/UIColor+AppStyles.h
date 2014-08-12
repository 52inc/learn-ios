//
//  UIColor+AppStyles.h
//  Alliance
//
//  Created by Brendan Lee on 7/8/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface UIColor (AppStyles)

+(UIColor*)allianceTitleColor;

+(UIColor*)empireTitleColor;

+(UIColor*)allianceSubtitleColor;

+(UIColor*)allianceCellBackgroundColor;

+(UIColor*)allianceCellHighlightBackgroundColor;

+(UIColor*)allianceNavigationBarColor;

+(UIColor*)allianceCellDividerColor;

+(UIColor*)allianceAccessoryTintColor;

@end
