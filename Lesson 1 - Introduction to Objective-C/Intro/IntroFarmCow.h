//
//  IntroFarmCow.h
//  Intro
//
//  Created by Brendan Lee on 6/14/14.
//  Copyright (c) 2014 52Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntroFarmAnimal.h"

@interface IntroFarmCow : NSObject<IntroFarmAnimal>

//Required
-(NSString*)animalTypeName;
-(void)makeASound;

//Optional
-(void)eatVegetable:(NSString*)vegetable;

//Cow's don't eat meat, so we'll omit that optional method.
@end
