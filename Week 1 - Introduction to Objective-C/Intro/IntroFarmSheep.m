//
//  IntroFarmSheep.m
//  Intro
//
//  Created by Brendan Lee on 6/14/14.
//  Copyright (c) 2014 52Inc. All rights reserved.
//

#import "IntroFarmSheep.h"

@implementation IntroFarmSheep

//Required
-(NSString*)animalTypeName
{
    return @"Sheep";
}

-(void)makeASound
{
    NSLog(@"Bahhh");
}

//Optional
-(void)eatVegetable:(NSString*)vegetable
{
    NSLog(@"%@ eats %@", [self animalTypeName], vegetable);
}


@end
