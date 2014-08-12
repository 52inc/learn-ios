//
//  FTIAllianceProfile.h
//  Alliance
//
//  Created by Brendan Lee on 7/8/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTIAllianceProfile : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *profileDescription;
@property(nonatomic,strong)NSString *profileImage;


-(instancetype)initWithDictionary:(NSDictionary*)dictionary;
-(NSDictionary*)dictionaryValue;

+(UIImage*)profilePlaceholderForName:(NSString*)name withSize:(CGSize)size;

@end
