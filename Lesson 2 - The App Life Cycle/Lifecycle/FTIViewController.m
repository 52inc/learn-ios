//
//  FTIViewController.m
//  Lifecycle
//
//  Created by Brendan Lee on 6/18/14.
//  Copyright (c) 2014 52Inc. All rights reserved.
//

#import "FTIViewController.h"

/**
 This is one of the few times in the video series you'll see me copy and paste code. However, as you can see below there isn't much to this. Your first question is probably 'what are these methods, where did they come from, and do I expect you to already know this?'. The answer to all 3 is: I'm about to tell you about them.
 
 These are events in your view controller's life cycle.
 
 Remember back to the first week where we wrote a custom initializer. Below you'll see 3 initializer's that the view controller class implements. Apple provides this class for us as a part of UIKit. Apple has implemented each of these 3 initializers already. When we do a subclass of their view controller, which is what all your view controllers will be, it's our responsibility to override them and add in any custom functionality we need to support our subclass.
 
 Since we're just walking through life cycle events this video, we won't be adding any additional functionality. 
 
 We've just overriden them to show you a few things:
 • They exist
 • You should ALWAYS call super's implementation of a method that you override unless it doesn't exist on the superclass. Believe it or not, this happens. Thanks to Objective-C's dynamic langauge semantics, the super-class can check to see if you've implemented a method in your subclass before attempting to call it when an event occurs. Although the implementaton of the super class may seem obvious (and like something you could just take care of yourself), I assure you that most of the time the super classes implementation is manipulating private variables and keeping them in equilibrium so that your object stays happy. Always call the super class unless you have a really, really, really good reason not to. "Because I can just do it myself" is not a good reason.
 • We've added log statements so that you can see in what order they run.
 • Not all of these need to be implemented or overriden...just the ones you need.
 
 */
 

@interface FTIViewController ()

@end

@implementation FTIViewController

/**
 This is the standard initializer. If you call this, you'll get an empty view controller with no content. If you create your views entirely programmatically, this is what you want!
 */
-(instancetype)init
{
    self = [super init];
    
    if (self) {
        NSLog(@"FTIViewController -init");
    }
    
    return self;
}

/**
 But, most of the time we'll initialize it with content from Interface Builder. Most coders hate interface tools and prefer programmatic approaches. You can do that here, but I strongly suggest you don't. Things like the auto-layout technology that iOS uses is difficult to do in code, although not impossible. Apple *heavily* encourages the use of Interface Builder. Not only does it allow you to somewhat preview your UI, it serves as an additional way to seperate UI logic from your interaction and data logic. Plus, if you work with a designer then your designer can make some tweaks without you.
 
 Unlike some languages, Interface Builder doesn't translate your layouts to code. It translates them to temporary Interface Builder XML file that is then compiled into an actual Interface Builder file when you run a build. This file loads all of the view elements when initialized and attaches them to the variables you've declared. Interface Builder is actually really good...especialyl compared with UI design tools in most languages. It's *almost* what you see is what you get. Things like auto-layout can sometimes throw a kink into it, however.
 
 -initWithCoder: is called on any class (view controller or not) being created from an Interface Builder document. That is, the class exists in an Interface Builder document and the initialization of that xib file is what is allocating and initializing your class. For this project, this is only invoked by the Storyboard. If you look in the Storyboard file, you'll see the actual View Controller class object.
 
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        NSLog(@"FTIViewController -initWithCoder:");
    }
    
    return self;
}

/**
 Unlike -initWithCoder:, this method exists on view controllers only. 
 
 In -initWithCoder, the xib (or storyboard) is actuall allocating and initializing the view controller. That means the Interface Builder file is loaded *before* the view controller is created. If you take a look at the '-' sign on the method declaration, you'll notice that this method requires an instantiated class in order to run. That means we already have to have an -alloc'd view controller object to send the name of the xib file we want to load!
 
 Well, if the xib file isn't creating our VC, then what's it doing? Its creating the 'view' object that the VC manages. In our xib file is a view. Only a view. No view controller or anything. You'll notice the File's Owner property up here. This is the our view-controller. It's going to 'own' the xib being opened. We set the "File's Owner" to the view controller we want to connect things in this xib file to. Important note: File's Owner isn't a real object. The xib file won't create this for you. It just attaches things to an existing object. Now that we've set that to our view controller, we can right click on it to see what variables are available for Interface Builder to connect to. Before you start getting worried, this video isn't going to cover working with Interface Builder. That's next weeks video. For now, you just need to understand that right-click on things over in this list let you see variables on the object. Now (and here's the fun and confusing part) I can drag a line from this variable to the Interface Builder element I want to attach it to. Once I've attached view to File's Owner, that means that the 'view' variable of my view controller is set to this specific element.
 
 When I load this xib file via -initWithNibName:bundle:, the super view-controller class will take name of the xib file I give it, load that file from disk, and then take care of connecting these variables for me. UIKit always manages the loading of xib files for you, so don't worry about this. Again, we'll cover Interface Builder in depth in the next video. Don't worry about this for now, other than knowing this is a stand-alone Interface Builder file, rather than a storyboard.
 */

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        NSLog(@"FTIViewController -initWithNibName:bundle:");
    }
    
    return self;
}

/**
 After the view has been loaded (no matter how), -viewDidLoad is called so that you can do further customization or setup. Changing colors, adding style, etc. can be done here.
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"FTIViewController -viewDidLoad");
}

/**
 -loadView manages the creation and loading of the view. If you want the super class to create a generic, empty view you can call super and then start adding other elements to screen after your call to [super loadView].
 
 If you want to use a completely custom view type, override this and *don't* call super. This is a rare occasion where you don't want super's implementation to run. Just make sure you've assigned your UIView subclass to self.view before the end of the method.
 */

-(void)loadView
{
    [super loadView];
    
    NSLog(@"FTIViewController -loadView");
}

/**
 If your view controller is loading from an xib file in any way (storyboard or individual xib), this method is called once Interface Builder is finished. You can use this to customize elements, remove certain things from the view, etc. Think of this as an unpacking stage. We aren't getting the house pretty, just unpacking the boxes.
 
 Fun fact: You can do styling here to make it pretty if you want, there's some debate as to whether its better to do it here, or in -viewDidLoad.
 */
-(void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"FTIViewController -awakeFromNib");
}

/**
 Each view is responsible for laying out its subviews. Views exist as a hierarchy. Views contain other views. In this case, your view controller's view will contain labels, switches, buttons, controls, tables, and more! Those individual views take care of laying themselves out and making sure they render themselves correctly.
 
 It's your job to make sure they're laid out next to each other correctly.
 
 You can do that here, or with (or in conjunction with) auto-layout or resizing masks. Again, don't get bogged down on these terms for now. We'll cover these layout technologys later in depth. But, its important to know that when a new layout needs to happen that this is invoked automatically by the view controller superclass so that you can make your layout adjustments.
 */

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSLog(@"FTIViewController -viewWillLayoutSubviews");
}

/**
 This method is called right before your view controller is about to be displayed. This is before any system animations or transitions occur. Use this method to reset things. Undo animations, set something to transparent that needs to fade in, clear out things in the UI, or update the UI with new information. Do it here before your view controller is on screen so the user doesn't see it.
 */

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"FTIViewController -viewWillAppear:");
}

/**
 This method is called as soon as your view controller is displayed. Update data, start an animation, begin loading something, prompt the user, etc.
 */

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"FTIViewController -viewDidAppear:");
}

/**
 This method is called right before your view controller is about to be hidden. This doesn't mean destroyed, it just means hidden. It could be hidden by another controller opening in front of it, pushing to a new view in a navigation controller, going to the background, or being interrupted by system events.
 
 Use this method to prepare to stop intensive things, get rid of things you can redisplay in -viewWillAppear:, etc. Be a model citizen and try to use as little processing, memory, or graphics as possible in this view controller while it isn't the primary active thing.
 */

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"FTIViewController -viewWillDisappear:");
}

/**
 This method is called as soon as your view controller is hidden. This is after any system animations or transitions occur. Use this method to actually stop intensive things, get rid of things you can redisplay in -viewWillAppear:, etc. Be a model citizen and try to use as little processing, memory, or graphics as possible in this view controller while it isn't the primary active thing.
 */

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"FTIViewController -viewDidDisappear:");
}

/**
 Oh, no! Low memory!! The system is running low on memory. Probably because of you. But, this happens as these devices have limited RAM. When this happens, the system also starts killing background processes to free up a little bit more RAM for you. But, you're still likely using more than you need to be. Use this warning as an opportunity to get rid of anything not essential. Image caches, file caches, and more are all fair game. If you aren't using them, get rid of them or risk your app's stability. You can always reload them later when you need them again.
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    NSLog(@"FTIViewController -didReceiveMemoryWarning");
}

/**
 Rotation support! Rotation is changing in a big way in iOS 8. This method will be deprecated and should no longer be used as of iOS 8 this fall. But, for now its the best thing we have to know when a rotation occurs. This method is called right before the rotation animation occurs. It allows you to begin and animate your own layout changes that can be synchronized with the system's own rotation animation. Start your updates and animation here!
 */
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
 
    NSLog(@"FTIViewController -willRotateToInterfaceOrientation:duration:");
}

/** Rotation support! Rotation is changing in a big way in iOS 8. This method will be deprecated and should no longer be used as of iOS 8 this fall. This method is called immediately after rotation (and the animation) occurs. Use this as one final pass for any non-animatable properties or layout that needed to be changed.
 */
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    NSLog(@"FTIViewController -didRotateFromInterfaceOrientation");
}

@end
