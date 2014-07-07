//
//  FTINumberedViewController.m
//  Navigation
//
//  Created by Brendan Lee on 7/6/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import "FTINumberedViewController.h"
#import "UIColor+Random.h"

@interface FTINumberedViewController ()
@property (strong, nonatomic) IBOutlet UILabel *screenNumberLabel;

@end

@implementation FTINumberedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //You can set additional properties for your VC's tabbar entry. The VC itself has a 'tabbar item' object that the UITabBarController uses to generate its tab.
        [self.tabBarItem setImage:[UIImage imageNamed:@"map"]];
        [self.tabBarItem setBadgeValue:@"1"];
        
        //You can also use a different image for the selected state. This is used often, as in iOS 7 'selected' images are filled while 'deselected' images are outliens.
        //[self.tabBarItem setSelectedImage:[UIImage imageNamed:@"map"]];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Invoke the setter again on load to make sure that the label has the current value. Its likely this value was set *before* the view was loaded form the XIB file. That would mean the format string would've been asssigned to a nil object, and never fixed once the label existed.
    self.screenNumber = self.screenNumber;
    
    //As you may have noticed in other apps, you can put items in the UINavigatonController's UINavigationBar. Here's how to put a simple button in the top right.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(plusButtonPressed:)];
    
    NSLog(@"Loaded Numbered VC");
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //We want to clear the notification after we look at it, so set it back to nil.
    [self.tabBarItem setBadgeValue:nil];
}

-(void)plusButtonPressed:(id)sender
{
    //Usually you'd want to do something *real* when you press the + button. But, this is an example. We'll build on this in Workshop #1 to add contacts to a table. (Shh... I just told what the workshop was a week early.)
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Added" message:@"An imaginary item has been added somewhere." delegate:nil cancelButtonTitle:@"If you say so." otherButtonTitles: nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setScreenNumber:(int)screenNumber
{
    //This is a custom setter. We override the auto-synthesis of the property declaration. We have to assign the parameter to the variable ourselves, then we can do any custom work we want to do when the value is set. In this case, we want to update the label and title.
    _screenNumber = screenNumber;
    
    _screenNumberLabel.text = [NSString stringWithFormat:@"Screen %d", _screenNumber];
    
    self.title = [NSString stringWithFormat:@"Screen %d", _screenNumber];
    
    NSLog(@"Set number to: %d", _screenNumber);
}

- (IBAction)presentVC:(id)sender {
    
    FTINumberedViewController *nextController = [[FTINumberedViewController alloc] initWithNibName:@"FTINumberedViewController" bundle:nil];
    nextController.screenNumber = _screenNumber + 1;
    nextController.view.backgroundColor = [UIColor randomColor];
    
    //Effects!
    nextController.modalTransitionStyle = UIModalTransitionStyleCoverVertical; //Default
    //nextController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //nextController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //nextController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    
    [self presentViewController:nextController animated:YES completion:^{
        NSLog(@"Presentation Finished.");
    }];
    
}

- (IBAction)dismissVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Dismiss Finished.");
    }];
}

- (IBAction)pushVC:(id)sender {
    
    //In practice, you don't need to check for self.navigationController before you call a method on it. If self.navigationController is nil, the operation just won't run. BUT: If you show your VC in a nav control sometimes, and 'present' it other times you can check here this to determine which way you want to make it behave.
    
    FTINumberedViewController *nextController = [[FTINumberedViewController alloc] initWithNibName:@"FTINumberedViewController" bundle:nil];
    nextController.screenNumber = _screenNumber + 1;
    nextController.view.backgroundColor = [UIColor randomColor];
    
    //Custom transitions on UINavigationController push/pops are possible in iOS7. However, its an entirely manual process and beyond the scope of this lesson. If you're interested, checkout UIViewControllerAnimatedTransitioning protocol.
    
    if (self.navigationController) {
        [self.navigationController pushViewController:nextController animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No!" message:@"This controller is not embedded in a navigation controller." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)popVC:(id)sender {
    
    //In practice, you don't need to check for self.navigationController before you call a method on it. If self.navigationController is nil, the operation just won't run. BUT: If you show your VC in a nav control sometimes, and 'present' it other times you can check here this to determine which way you want to make it behave.
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No!" message:@"This controller is not embedded in a navigation controller." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)popRootVC:(id)sender {
    
    //In practice, you don't need to check for self.navigationController before you call a method on it. If self.navigationController is nil, the operation just won't run. BUT: If you show your VC in a nav control sometimes, and 'present' it other times you can check here this to determine which way you want to make it behave.
    
    if (self.navigationController) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No!" message:@"This controller is not embedded in a navigation controller." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}
@end
