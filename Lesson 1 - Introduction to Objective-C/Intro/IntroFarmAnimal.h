//
//  IntroFarmAnimal.h
//  Intro
//
//  Created by Brendan Lee on 6/14/14.
//  Copyright (c) 2014 52Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A protocol is very similar to Java's interface keyword. A protocol is a list of methods that a class can declare to honor. The UI libraries use these extensively for callbacks.
 */

@protocol IntroFarmAnimal <NSObject>

//The compiler enforces required methods
@required
-(NSString*)animalTypeName;
-(void)makeASound;

/**
 Optional methods are not enforced or warned against. If you attempt to call an optional method without checking to see if it exists...you're just asking for a crash. Always check for the existance of an optional method before calling it.
 */
@optional
-(void)eatVegetable:(NSString*)vegetable;
-(void)eatAnimal:(NSString*)animal;

@end
