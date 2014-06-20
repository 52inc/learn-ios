//
//  IntroFarmPig.h
//  Intro
//
//  Created by Brendan Lee on 6/14/14.
//  Copyright (c) 2014 52Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntroFarmAnimal.h"

//Implements the intro farm animal protocol
@interface IntroFarmPig : NSObject<IntroFarmAnimal>

//Required
-(NSString*)animalTypeName;
-(void)makeASound;

//Optional
-(void)eatVegetable:(NSString*)vegetable;
-(void)eatAnimal:(NSString*)animal;

@end
