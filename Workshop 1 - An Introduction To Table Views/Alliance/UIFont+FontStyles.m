//
//  UIFont+FontStyles.m
//  Alliance
//
//  Created by Brendan Lee on 7/8/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import "UIFont+FontStyles.h"

@implementation UIFont (FontStyles)

+(UIFont*)allianceTitleFont
{
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:17.0];
}

+(UIFont*)allianceSubtitleFont
{
    return [UIFont fontWithName:@"HelveticaNeue-Regular" size:15.0];
}

+(UIFont*)allianceSectionHeaderFont
{
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:17.0];
}

@end
