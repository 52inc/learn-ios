//
//  FTIViewController.m
//  UIFundamentals
//
//  Created by Brendan Lee on 6/25/14.
//  Copyright (c) 2014 52Inc. All rights reserved.
//

#import "FTIViewController.h"

@interface FTIViewController ()

/**
 The first 2 items I typed by hand. You'll likely notice that the nonatomic,strong is in the opposite order. Order for property characteristics doesn't matter. Xcode puts them in a different order (as of recent version) and muscle memory keeps me typing the old way. Use whichever you choose!
 */
@property(nonatomic,strong)IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UISwitch *animationSwitch;
@property (strong, nonatomic) IBOutlet UIButton *backgroundColorButton;

@end

@implementation FTIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

/**
 UI elements aren't cleaned up on memory warnings. However, as we later get to tableviews and collection views you may want to clear the caches on their data sources. Other than that, don't try to destroy your UI elements here. You won't be given the chance to recreate them, and worse you could still be on screen!
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 An IBAction is a method that can be called by an Interface Builder 'event'. These connect to the 'Sent Events' available on some UI elements. Note that not all UIElements can send events. 
 
 IBAction is specified as a return type. However, its actually equivalent to void. Interface Builder just uses this as a flag to determine what that the method is available for hook ups in Interface Builder.
 
 id is the generic object format. You can change this to a more specific type (for example if ONLY segmented controls call this, we can change the object type to UISegmentedControl in the method parameter so we don't have to cast it later.) All UI elements descend from UIView, and most interactive ones descend from UIControl. Its common to use one of these 2 superclass object types as the parameter object type.
 
 sender is the variable name of the parameter that contains the UI element that activated the method from Interface Builder.
 
 */

-(IBAction)updateLabelValue:(id)sender
{
    //Label needs to show "<textfield value>: <slider value as decimal or percent>"
    
    //We'll query the currently selected index of the segmented control. If the index is '0' we'll show it as a percentage. If it isn't, we'll show it as a decimal.
    BOOL shouldShowPercentage = _segmentedControl.selectedSegmentIndex == 0;
    
    if (shouldShowPercentage) {
        /**
         We'll get the UITextField's contents by accessing the -text property on the UITextField assigned to 'textField'.
         
         The slider has a current value and a maximum value. The maximum value can be changed, so if you want the percentage you should divide current value by maximum possible value.
        */
        _titleLabel.text = [NSString stringWithFormat:@"%@: %d%%", _textField.text, (int)((_slider.value/_slider.maximumValue)*100)];
    }
    else
    {
        _titleLabel.text = [NSString stringWithFormat:@"%@: %f", _textField.text, _slider.value];
    }
    
}

-(IBAction)changeBackgroundColor:(id)sender
{
    /**
     arc4random() % <number> will generate an integer between 0 and the <number> (not including <number>).
     
     UIColor takes RGB color values as a decimal between 0.0 and 1.0, as a percentage. 0.0 being none, 1.0 being 100%. We'll divide the number we get from arc4random() % <number> by 255 to get a decimal percentage. You can use any number instead of 255 in the examples below and it will still work (as long as you change BOTH 255's in each line. However, I use 255 as thats the number you'll be using most....designers work in 0-255 color values. You get to convert them.
     
     There are some compiler macro shortcuts available to simplify this, as this gets quite redundant after a while. Its outside the scope of this week's lesson, but if you'd like the 2 line macro, email me at brendan@52inc.co and I'll be happy to pass it along.
     */
    
    float randomRed = (arc4random() % 255)/255.0;
    float randomGreen = (arc4random() % 255)/255.0;
    float randomBlue = (arc4random() % 255)/255.0;
    
    if (_animationSwitch.on) {
        
        /**
         UIView has several Class methods for animations. All UI elements descend from UIView, even windows. The UIView Class has a built-in animation engine based on Core Animation. The simplist animation method we use below.
         
         duration is the total amount of time for the animation to take
         
         animations is a block. A block is like a closure or lamda in other languages. Its a chunk of code (sometimes that accepts parameters) that is passed as a variable to another method. 
         
         Blocks will be covered in a later video, however the core concept is: 
            Your code inside the block isn't being executed now. Its being wrapped into a 'block' variable type and passed to the method. The method will run its own code to setup the animation, then when it decides it needs to know your changes it will run your block of code (looks much like a function call). After your block is done executing, the animation method will continue with its logic until finished and will then return. 
         
         Note: Blocks are asynchronous. They can be called on other threads at unknown times. In this case, it runs on the main thread (after the -animateWithDuration:animations: method has completed and returned) as the animation is scheduled and rendered.
         
         In this animation method you can animate any property on a UIView that is marked as animatable. The UIView documentation will tell you if a property change is animatable. Most properties affecting presentation are animatable. Set the final value of the property inside the block. UIView will automatically animate the change from the current value to the new value. No hand interpolations, time functions, or keyframes. (You can do those things in the more advanced techniques if you want.)
         */
        
        [UIView animateWithDuration:1.0 animations:^{
            self.view.backgroundColor = [UIColor colorWithRed:randomRed green:randomGreen blue:randomBlue alpha:1.0];
            _backgroundColorButton.transform = CGAffineTransformRotate(_backgroundColorButton.transform, M_PI);
            //_backgroundColorButton.center = CGPointMake(_backgroundColorButton.center.x, _backgroundColorButton.center.y+25);
        }];
    }
    else
    {
        self.view.backgroundColor = [UIColor colorWithRed:randomRed green:randomGreen blue:randomBlue alpha:1.0];
    }
}

-(IBAction)closeKeyboard:(id)sender
{
    //A first responder is essentially 'current focus' for events. The first responder can choose to deal with the event, or pass it to the next item in the responder chain.
    [sender resignFirstResponder];
}

/*
 ***********************
 BONUS CODE!
 ***********************

 I didn't show how to create all of these UI elements by hand in code in the video. However, if you want to see how loading them via code works and expirament, I've implemented the functional (non-label) parts of this project below. 
 
 I've commented out the implemented version here so that it doesn't affect everyone following along in the videos. 
 
 If you want to experiment past the bounds of Interface Builder and the video, uncomment -loadView and -viewWillLayoutSubviews (below) and then change the loading code in App Delegate to the 'manual' version.
 */

/*
 -(void)loadView
 {
 [super loadView];
 
 //First thing to note: Marking something as 'IBOutlet' doesn't mean you can't create it in code. But, if you want to support IBOutlet *and* code, you may want to check what elements where created by IB and what weren't. Only create elements that don't exist already. You can do this by checking to see if the variable is nil or not. A quick If statement like these below will suffice!
 
 //Second note: For labels that are on screen (like the ones labeling each element) you'll want to add instance variables and store the labels to them that way you can do the layout for them in -viewWillLayoutSubviews. In the interest of not complicating this for those wishing to understand Interface Builder, I've omitted the description labels for each element from this code. You'll just get the UI elements.
 
 //The layout will be done in -viewWillLayoutSubviews.
 
 NSLog(@"Manual Load View");
 
 //Change the initial black to white.
 self.view.backgroundColor = [UIColor whiteColor];
 
 if (!_titleLabel) {
 _titleLabel = [[UILabel alloc] init];
 _titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
 _titleLabel.text = @"UILabel";
 _titleLabel.textAlignment = NSTextAlignmentCenter;
 
 [self.view addSubview:_titleLabel];
 }
 
 if (!_slider) {
 _slider = [[UISlider alloc] init];
 
 //Add the target method to the event the UI element sends.
 [_slider addTarget:self action:@selector(updateLabelValue:) forControlEvents:UIControlEventValueChanged];
 
 [self.view addSubview:_slider];
 }
 
 if (!_textField) {
 _textField = [[UITextField alloc] init];
 _textField.placeholder = @"Label Prefix";
 _textField.borderStyle = UITextBorderStyleRoundedRect;
 
 //Add the target method to the event the UI element sends.
 [_textField addTarget:self action:@selector(updateLabelValue:) forControlEvents:UIControlEventEditingChanged];
 [_textField addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
 
 [self.view addSubview:_textField];
 }
 
 if (!_segmentedControl) {
 _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Show Percentage", @"Show Decimal"]]; //This item list is an NSArray literal. Its a shortcut to NSArray arrayWithObjects:. You can use any array of NSStrings here.
 _segmentedControl.selectedSegmentIndex = 0;
 
 //Add the target method to the event the UI element sends.
 [_segmentedControl addTarget:self action:@selector(updateLabelValue:) forControlEvents:UIControlEventValueChanged];
 
 [self.view addSubview:_segmentedControl];
 }
 
 if (!_animationSwitch) {
 _animationSwitch = [[UISwitch alloc] init];
 _animationSwitch.on = YES;
 
 [self.view addSubview:_animationSwitch];
 }
 
 if (!_backgroundColorButton) {
 _backgroundColorButton = [UIButton buttonWithType:UIButtonTypeCustom];
 [_backgroundColorButton setTitle:@"Change Background State" forState:UIControlStateNormal];
 [_backgroundColorButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
 
 //Add the target method to the event the UI element sends.
 [_backgroundColorButton addTarget:self action:@selector(changeBackgroundColor:) forControlEvents:UIControlEventTouchUpInside];
 
 [self.view addSubview:_backgroundColorButton];
 }
 }
 
 -(void)viewWillLayoutSubviews
 {
 [super viewWillLayoutSubviews];
 
 //Let's do a manual layout of all of our UI elements that didn't come from Interface Builder. This is automatically called on rotation, when the view requests a layout, or when the system determines a new layout is required.
 
 //DO NOT use exact numbers for widths, heights, and locations unless you REALLY mean it. Make them relative. Use system provided variables to size your elements and determine their location.
 
 NSLog(@"Manual Subview Layout");
 
 float horizMargins = 20.0;
 float elementMargins = 25.0;
 
 float widthForItems = self.view.bounds.size.width - (2*horizMargins);
 
 _titleLabel.frame = CGRectMake(horizMargins, self.topLayoutGuide.length, widthForItems, 50.0);
 
 _slider.frame = CGRectMake(horizMargins, self.topLayoutGuide.length + CGRectGetMaxY(_titleLabel.frame) + elementMargins, widthForItems, _slider.bounds.size.height); //Some elements have required heights. This is one of them. Use the elements existing height in all your calculatings.
 
 _textField.frame = CGRectMake(horizMargins, self.topLayoutGuide.length + CGRectGetMaxY(_slider.frame) + elementMargins, widthForItems, 30.0); //Although not all textfields have a required height, the default style with a border and fill does.
 
 _segmentedControl.frame = CGRectMake(horizMargins, self.topLayoutGuide.length + CGRectGetMaxY(_textField.frame) + elementMargins, widthForItems, _segmentedControl.bounds.size.height); //Another element with a specific height (doing a bad job here of showing examples of dynamic and relative heights!) This particular style of segmented control is 29pt tall.
 
 _animationSwitch.frame = CGRectMake(self.view.bounds.size.width-horizMargins-_animationSwitch.bounds.size.width, self.topLayoutGuide.length + CGRectGetMaxY(_segmentedControl.frame) + elementMargins, _animationSwitch.bounds.size.width, _animationSwitch.bounds.size.height); // This one actually has a specific width AND height! Plus, we want to right align it!
 
 _backgroundColorButton.frame = CGRectMake(horizMargins, self.topLayoutGuide.length + CGRectGetMaxY(_segmentedControl.frame) + (100.0), widthForItems, 50.0);
 }
 
 */


@end
