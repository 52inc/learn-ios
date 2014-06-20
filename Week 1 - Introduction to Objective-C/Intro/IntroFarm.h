//
//  IntroFarm.h
//  Intro
//
//  Created by Brendan Lee on 6/14/14.
//  Copyright (c) 2014 52Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Let's break down what's in this header file. A header file is a public declaration of your class and its functionality to other classes. What ever you put here is public knowledge and accessible / callable by other objects.
 
 If you've ever worked in Java, you've likely seen the interface keyword. However, Objective-C doesn't use this keyword the same way. In Objective-C, an interface is where you define the attributes and operations of class. An Objective-C protocol is equivalent to an interface in Java.
 
 You don't do the implementation or variable initialization here. After @interface you'll see the class name. "IntroFarm". After the colon, you'll see the object our IntroFarm is subclassed from. All Objective-C objects you'll work with will descend from NSObject. Even as you later subclass UI controls and other objects, they all eventually trace their lineage to NSObject. NSObject provides a large amounf of functionality your objects, which we'll investigate later.
 
 The following items are commonly found in an interface:
 • Instance variables
 • Properties
 • Method headers
 
 Let's start with the first one, instance variables.
 
 Instance variables are variables that exist in your class scope. Each instance of your class has its own copy of these variables. Resist the urge to put variables better served in your local scope here.
 
 */

@interface IntroFarm : NSObject
{
    int numberOfFeeders;
    BOOL happyAnimals; //BOOL with all capital letters is a new type! See more info below.
    
    /**
     This is functionally identical to a C bool variable, but uses 'YES' and 'NO' instead of true/false. This is used in place of your standard bool in Objective-C code. Currently, its interchangable with C bools...however Apple's frameworks use the BOOL type. To make sure your code remains compatible should Apple change the definition of the BOOL type in the future (weirder things have happend) you should always use the BOOL type in your Objective-C code.
     */
}


/**
 Properties. Properties are like intelligent instance variables. They not only act as instance variables, but they'll create setters / getters for you automatically! You can always override these setters / getters to add functionality. This is usually used to update the internal state of your object when the value changes, or to update the UI to a new value that's been set. I'll declare a property and then break down each component of the syntax.
 
 */

@property(nonatomic,strong)NSString* farmName;
@property(nonatomic,strong,readonly)NSString *owner;
@property(nonatomic,assign)int numberOfWorkers;

/**
• Nonatomic tells the compiler to not enforce thread safety on this property, and can lead to malformed objects if multiple threads attempt writing to the variable at once. Atomic enforces that a complete object will always be written here if 2 threads are competing, although nothing guarantees that it was the object you wanted.

• Strong relates to memory management. We're currently working in the age of ARC, automated reference counting. Since we're working in ARC, I won't spend too much time on manual memory management. But, I'll put a note in the show notes with a link to more information. As a simplistic explanation of what's happening here.... You can think of 'strong' as someone claiming 'I care about this object' a good visual is to imagine a person raising their hand in class room. Everyone that declares strong for an object raises their hand to indicate they care about that object staying alive. As long as more than 1 person has their hand up, the compiler will let the variable stay in memory. As objects are deallocated, or other objects are assigned to the property, hands slowly go down as no one cares about this object any more. When no one has their hand up, the compiler deallocates and removes this object from memory. Then, its gone. Its important to note that this varies greatly from Garbage Collecting. Garbage collecting is done at runtime and constantly watches references to objects. As long as a refererence exists, the Garbage Collector leaves it alone. This has a performance penalty, and can lead to memory issues if you create and destroy objects faster than the Garbage Collector can  clean them up, as it isn't instant. In ARC, all of this work is done at compile-time. When you hit the 'run' button the compiler analyses your code and manually inserts 'hands-up' and 'hands-down' commands into your code. Before ARC, you had to do this yourself. Now, the actual name for 'hands-up' and 'hands-down' is 'retain' and 'release'. Retain indicating that I want to 'own' this object and ensure I have it as long as I want, and 'release' which indicates that I'm done caring about it. ARC prevents you from including these commands yourself in your code, but the compiler does it for you. Before ARC, there was often the issue of incorrect retainCounts in code. What did this mean? Well, too low of a retain count meant that your object was deleted when other objects still wanted it. When it was referenced, apps would crash. The opposite problem was over retaining. If an object was over-retained, it could survive even after no one cared about it. This could lead to incredibly memory leaks. ARC solves this (for the most part). You still need to pay a little bit of attention, namely to properties, but nothing like before. Other than Strong, you also have weak. Weak  works similarly to strong, except that it doesn't place a 'retain' on the object. Think of it as 'its nice to have this variable, but if it goes away I'll be fine'. An important thing to watch out for is a retain-cycle. If 2 objects put a 'strong' hold on each other, then neither one of them will ever be deallocated because at least 1 other object cares about them. They become this pair that is lost off into memory, never to return and never to be deleted. This is the most common memory leak in ARC.

• Strong can only be used on objects. Assign is for primitives (and objects in rare cases). Assign avoids memory management responsibilties for this property. This is great, because primitives don't need object memory management. So, all primitive types use assign.

• Readonly specifies that a setter for this object will not be created. It can only be read by other objects, never set. Your object can set it when needed, however.

• There are more options for properties than this. But, these are the most common. I'll put a full list of property options in the show notes.

https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/EncapsulatingData/EncapsulatingData.html
*/


/**
 Now we'll move on to methods. Objective-c uses message passing rather than specific functions or methods. In practical use, this distinction comes up very rarely. Unlike most langauges where a method call directly invokes a method....in Objective-C, calling a method is actually passing a message to the object. The object can then decide what it wants to do with the message. Most of the time, thats invoking the requested method. But, other times it can choose to redirect the message to another object, not respond, throw an exception, or even create a brand new method at runtime (with a new name) and pass the message on to that. Objective-C is a very dynamic language, and message passing is a big part of that. But, unless you're wanting to use these features...they're fairly transparent to you and not in the way of your coding process. For now, we'll consider message passing to be the same as calling a method. With that in mind, let's declare a method. Objective-C is a very verbose language. You'll notice most of Apple's libraries use almost full sentences as method names. This is why auto-complete is your friend.
 
 */

/**
 If you're used to other languages, like Java, you'd see this next method written something like initFarm(NSString* farmName, NSString* ownerName, int workers). Objective-c names each parameter. We'll see how to call this method later, but for now remember that each parameter has a name, and that names is part of the method call. Its important to know that objective-c does NOT support method overloading. Name your methods slightly differently, usually indicating the type if needed.
 
 */

-(id)initWithFarmName:(NSString*)farmName owner:(NSString*)ownerName numberOfWorkers:(int)workers;

-(void)addAnimalsToFarm:(NSArray*)animals;

//A few more methods to work with later. These don't take any parameters, but they do return an array.
-(NSArray*)getSheep;

-(NSArray*)getCows;

-(NSArray*)getPigs;

-(NSArray*)allAnimals;

//Classes that haven't been instantiated can also have methods. This is the same concept as 'static' in Java.
//Class-level methods are denoted with a + sign instead of a minus in front of the method. This method can be invoked on the class itself.
+(NSString*)farmType;

@end
