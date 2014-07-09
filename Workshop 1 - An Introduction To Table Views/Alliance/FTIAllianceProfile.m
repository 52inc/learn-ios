//
//  FTIAllianceProfile.m
//  Alliance
//
//  Created by Brendan Lee on 7/8/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import "FTIAllianceProfile.h"

@implementation FTIAllianceProfile

-(instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        _profileDescription = dictionary[@"description"];
        _profileImage = dictionary[@"profile_image"];
    }
    
    return self;
}

-(NSDictionary*)dictionaryValue
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (_name) {
        dictionary[@"name"] = _name;
    }
    
    if (_profileDescription) {
        dictionary[@"description"] = _profileDescription;
    }
    
    if (_profileImage) {
        dictionary[@"profile_image"] = _profileImage;
    }
    
    return dictionary;
}

+(UIImage*)profilePlaceholderForName:(NSString*)name withSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    
    [[UIColor allianceCellDividerColor] set];
    
    CGContextFillEllipseInRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height));
    
    NSMutableString *initials = [NSMutableString string];
    
    NSArray *nameComponents = [name componentsSeparatedByString:@" "];
    
    for (int i=0; i<2 && i<nameComponents.count; i++) {
        if ([nameComponents[i] length] > 0) {
            [initials appendString:[nameComponents[i] substringToIndex:1]];
        }
    }
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributeDict = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                    NSFontAttributeName : [UIFont allianceSectionHeaderFont],
                                    NSParagraphStyleAttributeName : paragraph};
    
    CGRect textSize = CGRectIntegral([initials.uppercaseString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDict context:nil]);
    
    [initials.uppercaseString drawInRect:CGRectMake((size.width-textSize.size.width)/2.0, (size.height-textSize.size.height)/2.0, textSize.size.width, textSize.size.height)  withAttributes:attributeDict];
    
    UIImage *profileImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return profileImage;
}

@end
