//
//  IntroFarmCow.m
//  Intro
//
//  Created by Brendan Lee on 6/14/14.
//  Copyright (c) 2014 52Inc. All rights reserved.
//

#import "IntroFarmCow.h"

@implementation IntroFarmCow

//Required
-(NSString*)animalTypeName
{
    return @"Cow";
}

-(void)makeASound
{
    NSLog(@"Moo");
}

//Optional
-(void)eatVegetable:(NSString*)vegetable
{
    NSLog(@"%@ eats %@", [self animalTypeName], vegetable);
}


@end
