//
//  main.m
//  Intro
//
//  Created by Brendan Lee on 6/14/14.
//  Copyright (c) 2014 52Inc. All rights reserved.
//
// This tutorial is from the video series "Learn iOS" from 52inc. The video series is available at 52inc.co/learn-ios
// 
// This is from Video 1, "Introduction to Objective-C"


#import <Foundation/Foundation.h>
#import "IntroFarm.h"
#import "IntroFarmPig.h"
#import "IntroFarmSheep.h"
#import "IntroFarmCow.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        /**
         Common C primitives exist in Objective-C because it is a superset of C. This is the first and probably last time we'll work in the main.m file. For simplicity, we're working on a console application which removes us from the runloop of a GUI and the overhead of the app life cycle.
         */
        
        //Compiler warnings will appear, because I don't be using these variables past their initial declaration.
        
        int myInt = 0;
        bool myBool = true;
        float myFloat = 0.0f;
        double myDouble = 0.0;
        char myChar = 'a';
        char myCString[] = "Hello World";
        
        NSLog(@"Hello World"); // Can also use printf and other C functions for console
        
        // Link in show notes "String Format Specifiers" to get valid string formatters
        NSLog(@"myInt value: %d",myInt);
        
        for (int i = 0; i<100; i++) {
            
            if (i % 2 == 0) {
                NSLog(@"Even number: %d", i);
            }
            else
            {
                NSLog(@"Odd number: %d", i);
            }

        }
        
        //Ternary operators, for short conditional statements. This operation on the next line is identical to the 'if' statement following it.
        int myGrade = (myChar == 'a') ? 100 : 0;
        
        if (myChar == 'a') {
            myGrade = 100;
        }
        else
        {
            myGrade = 0;
        }
        
        NSLog(@"Grade: %d", myGrade);
        
        //That's all for a C recap! Now on to Objective-C objects.

        /**
         Foundation provides a wide variety of base objects. Strings, arrays, dictionaries (or hashmaps in some languages, associative arrays in others), number, and more. We'll be working with a few of them in this video.
         
         You're going to see some syntax we haven't covered yet. Don't worry, we'll get to it. For now, focus on the object types and not how they're created.
         */

        NSString *myStringObject = @"Hello World";
        
        NSArray *myArrayObject = [[NSArray alloc] initWithObjects:myStringObject, nil];
        
        NSDictionary *myDictionary = [[NSDictionary alloc] init];
        
        NSNumber *myNumber = [[NSNumber alloc] initWithInt:5];
        
        /**
         None of these elements are mutable. I can't modify the string, or the contents of the array, or the contents of the dictionary or the number. For that, we need the mutable subclasses of them.
         */
        
        NSMutableString *myMutableString = [NSMutableString stringWithString:@"Hello World"];
        
        NSMutableArray *myMutableArray = [[NSMutableArray alloc] init];
        
        NSMutableDictionary *myMutableDictionary = [[NSMutableDictionary alloc] init];
        
        //I'm not going to load any elements into these objects for now.
        
        /**
         Every object in Objective-C is a pointer.
        
         A pointer is a variable whose value is the address of another variable.
        
         What does this mean for us? Not much in standard usage, but there are a few key things to be aware of:
         
         • Because objective-c is a superset of C, it passes parameters by value. This means it makes a copy of the value and sends that to the method. For primitives, that means a copy of your variable is sent and any modifications won't affect your original variables. BUT: Objective-C objects are pointers, not primitives. What's 'copied' is the pointer itself, not the object. The new 'copied' pointer still refers to the original object.
         
        • This means that in practical use the exact object you pass as a parameter to a method is sent, not a copy. If the method you pass it to modifies it, your original copy is modified as well- even if the method doesn't return the object back to you.
        
        Let's create a few objects and then come back and see how we can use them.
        
       */
        
        //Now that we have all of our objects setup, let's see what they can do!
        
        //First, let's create our farm.
        
        IntroFarm *myFarm = [[IntroFarm alloc] initWithFarmName:@"Brendan's Farm" owner:@"Brendan" numberOfWorkers:5];
        
        //Next, let's add some animals!
        NSMutableArray *newAnimals = [NSMutableArray array];
        
        for (int i; i<25; i++) {
            //Let's randomly add an animal to the farm.
            
            int randomNumber = arc4random() % 3;//Produce a random number between 0-2.
            
            switch (randomNumber) {
                case 0:
                {
                    IntroFarmPig *pig = [[IntroFarmPig alloc] init];
                    [pig makeASound];
                    [newAnimals addObject:pig];
                }
                    break;
                case 1:
                {
                    IntroFarmCow *cow = [[IntroFarmCow alloc] init];
                    [cow makeASound];
                    [newAnimals addObject:cow];
                }
                    break;
                case 2:
                {
                    IntroFarmSheep *sheep = [[IntroFarmSheep alloc] init];
                    [sheep makeASound];
                    [newAnimals addObject:sheep];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        //Since NSMutableArray is a subclass of NSArray, it can be used anywhere a regular array can.
        [myFarm addAnimalsToFarm:newAnimals];
        
        //Now we have some animals! Let's see how many of each kind we ended up with!
        NSLog(@"%lu sheep, %lu cows, %lu pigs", (unsigned long)[myFarm getSheep].count, (unsigned long)[myFarm getCows].count, (unsigned long)[myFarm getPigs].count);
        
        //Next, let's feed the animals. Remember, some animals don't eat meet...and the array contains them all in a random order. So, we'll use reflection to sort this out!
        NSArray *allAnimals = [myFarm allAnimals];
        
        //We'll use a generic object that conforms to the IntroFarmAnimal protocol as the type of object in the colletion we're iterating through. Note that the object type you specify isn't enforced. But, you want to get as close as you can to the real type so that working with the object inside the loop is easier.
        
        for (id<IntroFarmAnimal> currentAnimal in allAnimals) {
            
            [currentAnimal makeASound];
            
            if ([currentAnimal respondsToSelector:@selector(eatAnimal:)]) {
                [currentAnimal eatAnimal:@"Buffalo"];
            }
            
            if ([currentAnimal respondsToSelector:@selector(eatVegetable:)]) {
                [currentAnimal eatVegetable:@"Celery"];
            }
        }
        
    }
    return 0;
}

