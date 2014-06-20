//
//  IntroFarm.m
//  Intro
//
//  Created by Brendan Lee on 6/14/14.
//  Copyright (c) 2014 52Inc. All rights reserved.
//

#import "IntroFarm.h"

#import "IntroFarmSheep.h"
#import "IntroFarmCow.h"
#import "IntroFarmPig.h"

@interface IntroFarm ()

@property(nonatomic,strong)NSArray* farmAnimals;

@end

@implementation IntroFarm

//NSObject includes the standard initializer 'init'. You'll usually want to override this method, even if you need (or want) to use your own initializer.
-(instancetype)init
{
    self = [self initWithFarmName:@"Farm Co." owner:@"Brendan" numberOfWorkers:5];// Call my custom initializer with default values.
    
    if (self) { //Always check to see if self was successfully created. If it wasn't, self will be set to 'nil'. Nil always evaluates to false in if statements, so its an excellent way to see if an object exists. If it is set, we'll start working with our instance variables and propreties. If it didn't succeed, its dangerous to begin modifying these properties as allocation or initialization may have failed. So we put these in an if statement to ensure we only manipulate them if hte object is in a good shape.
        
        
    }
    
    return self;
}

//Let's begin with initializers. Initializers always start with 'init'
-(instancetype)initWithFarmName:(NSString*)farmName owner:(NSString*)ownerName numberOfWorkers:(int)workers;
{
    self = [super init];
    
    if (self) {
        //Since our object was create and initialize successfully, we'll set our properties and instance variables to those from the initializer.
        _numberOfWorkers = workers; // Variables are 'synthesized' meaning they're created dynamicaly. When referring to them in your class, you can bypass the setter and getters (and possible restrictions from your properties) by using an underscore in front of the variable name to directly access it. This is convention in objective-c, but you can change it by override the synthesis yourself. We won't be covering that today.
        numberOfFeeders = workers; //Instance variables don't require the underscore.
        
        _farmName = farmName;
        _owner = ownerName;
        
        //Notice if I attempt to use the setter method, I get an error because its set to readonly. The method doesn't exist.
        //[self setOwner:ownerName];
        
        //Compare that to farmName, which isn't read-only
        [self setFarmName:farmName];
        
        //Properties can also be accessed via dot syntax. This syntax is equivalent to the one above, as it does invoke the setters and getters.
        self.farmName = farmName;
        
    }
    
    return self; // return self so the next subclass can run their initializer, or so the object that created this one can have a pointer back to it.
}

-(void)addAnimalsToFarm:(NSArray*)animals;
{
    //Let's add some animals to the farm. First, we need a place to store them....because I don't want everyone else to know my inventory, I'm not going to make this one public.
    
    if (!_farmAnimals) {
        _farmAnimals = animals.copy; // Copy it to ensure it can't be changed unknowngly later.
    }
    else
    {
        //If farm animals already exists, lets add the objects from the animals array to it.
        _farmAnimals = [_farmAnimals arrayByAddingObjectsFromArray:animals];
    }
}

-(NSArray*)getSheep
{
    //All of our animal objects are all jumbled in the array! How will we know whats a sheep?? Well, Objective-C utilizes reflection quite frequently. In case you aren't familiary, reflection is looking objectively at the object to discover things about it. Things like class type, what methods exist, if it implements a protocol (more on that later), and more! So, we'll use reflection to figure out what animals are sheep.
    
    //NSArrays aren't mutable. But, luckily for us NSMutableArray exists. Let's make a mutable array we can add objects to as we find them.
    
    NSMutableArray *selectedAnimals = [[NSMutableArray alloc] init];// You can also init this with other options. You can also use a class method as a shortcut, which I'll show you now. [NSMutableArray array]
    
    //We make a copy of the animals array in case another thread changes the contents of the array. If you use Objective-C's fast iteration and the content changes, an exception will be thrown.
    NSArray *animalsCopy = _farmAnimals.copy;
    
    //id is the generic type, because we don't know what kind of animal this is yet.
    
    for (id currentAnimal in animalsCopy) {
        
        //Time to figure out what this animal is.
        
        //NSObject includes a method that all subclasses, including our sheep inheirts.
        
        if ([currentAnimal isKindOfClass:[IntroFarmSheep class]]) {
            [selectedAnimals addObject:currentAnimal];
        }
    }
    
    return selectedAnimals.copy;
}

-(NSArray*)getCows
{
    NSMutableArray *selectedAnimals = [[NSMutableArray alloc] init];// You can also init this with other options. You can also use a class method as a shortcut, which I'll show you now. [NSMutableArray array]
    
    //We make a copy of the animals array in case another thread changes the contents of the array. If you use Objective-C's fast iteration and the content changes, an exception will be thrown.
    NSArray *animalsCopy = _farmAnimals.copy;
    
    //id is the generic type, because we don't know what kind of animal this is yet.
    
    for (id currentAnimal in animalsCopy) {
        
        //Time to figure out what this animal is.
        
        //NSObject includes a method that all subclasses, including our sheep inherits.
        
        if ([currentAnimal isKindOfClass:[IntroFarmCow class]]) {
            [selectedAnimals addObject:currentAnimal];
        }
    }
    
    return selectedAnimals.copy;
}

-(NSArray*)getPigs
{
    NSMutableArray *selectedAnimals = [[NSMutableArray alloc] init];// You can also init this with other options. You can also use a class method as a shortcut, which I'll show you now. [NSMutableArray array]
    
    //We make a copy of the animals array in case another thread changes the contents of the array. If you use Objective-C's fast iteration and the content changes, an exception will be thrown.
    NSArray *animalsCopy = _farmAnimals.copy;
    
    //id is the generic type, because we don't know what kind of animal this is yet.
    
    for (id currentAnimal in animalsCopy) {
        
        //Time to figure out what this animal is.
        
        //NSObject includes a method that all subclasses, including our sheep inherits.
        
        if ([currentAnimal isKindOfClass:[IntroFarmPig class]]) {
            [selectedAnimals addObject:currentAnimal];
        }
    }
    
    return selectedAnimals.copy;
}

-(NSArray*)allAnimals
{
    return _farmAnimals.copy;
}

//For our Class-level method, this will just return an string of the type of farm this is.
+(NSString*)farmType
{
    return @"Animal Farm";
}


@end
