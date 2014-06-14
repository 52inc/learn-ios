//
//  IntroFarmPig.m
//  Intro
//
//  Created by Brendan Lee on 6/14/14.
//  Copyright (c) 2014 52Inc. All rights reserved.
//

#import "IntroFarmPig.h"

@implementation IntroFarmPig

//Required
-(NSString*)animalTypeName
{
    return @"Pig";
}

-(void)makeASound
{
    NSLog(@"Oink!");
}

//Optional
-(void)eatVegetable:(NSString*)vegetable
{
    NSLog(@"%@ eats %@", [self animalTypeName], vegetable);
}

-(void)eatAnimal:(NSString*)animal;
{
    NSLog(@"%@ eats %@", [self animalTypeName], animal);
}


@end
