//
//  FTIViewController.m
//  Touches
//
//  Created by Brendan Lee on 7/27/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import "FTIViewController.h"

@interface FTIViewController ()

@property(nonatomic,strong)NSMapTable *touchViewMap;
@property(nonatomic,strong)NSMapTable *gestureViewMap;
@property(nonatomic,strong)UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation FTIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Configure view for multiple touches
    self.view.multipleTouchEnabled = YES;
    
    //Allocate and initialize a default instance of NSMapTable for tracking touches in views and for tracking touches in gestures.
    _touchViewMap = [NSMapTable new];
    _gestureViewMap = [NSMapTable new];
    
    //Create a gesture recognizer and add it to the screen.
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerDidPan:)];
    _panGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:_panGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIColor*)randomColor
{
    float red = (arc4random() % 255)/255.0;
    float green = (arc4random() % 255)/255.0;
    float blue = (arc4random() % 255)/255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

#pragma mark Touch Handling

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *currentTouch in touches) {
        UIView *touchTrackingView = [UIView new];
        touchTrackingView.bounds = CGRectMake(0, 0, 75, 75);
        touchTrackingView.backgroundColor = [self randomColor];
        touchTrackingView.center = [currentTouch locationInView:self.view];
        
        //Keep track of the view we created using the touch object as a key. The UITouch object is the same throughout the duration of the touch event.
        [_touchViewMap setObject:touchTrackingView forKey:currentTouch];
        
        [self.view addSubview:touchTrackingView];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *currentTouch in touches) {
        UIView *touchTrackingView = [_touchViewMap objectForKey:currentTouch];
        
        //Make sure that there is a view attached to this touch and that it is a subclass of UIView.
        if ([touchTrackingView isKindOfClass:[UIView class]]) {
            touchTrackingView.center = [currentTouch locationInView:self.view];
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *currentTouch in touches) {
        UIView *touchTrackingView = [_touchViewMap objectForKey:currentTouch];
        
        //Make sure that there is a view attached to this touch and that it is a subclass of UIView.
        if ([touchTrackingView isKindOfClass:[UIView class]]) {
            
            //Remove it from the screen
            [touchTrackingView removeFromSuperview];
            
            //Remove it from the hash map
            [_touchViewMap removeObjectForKey:currentTouch];
        }
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark Gesture Recognizer
-(void)gestureRecognizerDidPan:(UIPanGestureRecognizer*)gestureRecognizer
{
    //Important! A Gesture Recognizer can only maintain 1 event sequence at a time. If a 'pan' is ongoing, and another one is started, the second gesture will be ignored since the first gesture is actively being tracked. We make some assumptions based on this in the logic below. Namely, that touch indexes are static, that no other gesture recognizers will be accessing our gesture Hash Map during an ongoing pan, and that all touches in the gesture hash map are for the current gesture event.
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            for (int i=0; i<gestureRecognizer.numberOfTouches; i++) {
                
                //We can't get the actual UITouch objects from the recognizer, we can only get their location by index.
                CGPoint locationOfTouch = [gestureRecognizer locationOfTouch:i inView:self.view];
                
                UIView *touchTrackingView = [UIView new];
                touchTrackingView.bounds = CGRectMake(0, 0, 50, 50);
                touchTrackingView.backgroundColor = [self randomColor];
                touchTrackingView.center = locationOfTouch;
                
                //Keep track of the view we created using the index number as a key. The index number is the same throughout the duration of the touch event.
                [_gestureViewMap setObject:touchTrackingView forKey:[NSString stringWithFormat:@"%d", i]];
                
                [self.view addSubview:touchTrackingView];
            }

        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            for (int i=0; i<gestureRecognizer.numberOfTouches; i++) {
                
                //We can't get the actual UITouch objects from the recognizer, we can only get their location by index.
                CGPoint locationOfTouch = [gestureRecognizer locationOfTouch:i inView:self.view];
                
                UIView *touchTrackingView = [_gestureViewMap objectForKey:[NSString stringWithFormat:@"%d", i]];
                
                //Make sure that there is a view attached to this touch and that it is a subclass of UIView.
                if ([touchTrackingView isKindOfClass:[UIView class]]) {
                    touchTrackingView.center = locationOfTouch;
                }
            }
        }
            break;
        case UIGestureRecognizerStateFailed:
        {
            for (NSString *viewIndexNumber in _gestureViewMap) {
                
                UIView *touchTrackingView = [_gestureViewMap objectForKey:viewIndexNumber];
                
                //Make sure that there is a view attached to this touch and that it is a subclass of UIView.
                if ([touchTrackingView isKindOfClass:[UIView class]]) {
                    
                    //Remove it from the screen
                    [touchTrackingView removeFromSuperview];
                }
            }
            
            //Remove all objects from the hashmap after the gesture completes.
            [_gestureViewMap removeAllObjects];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            for (NSString *viewIndexNumber in _gestureViewMap) {
                
                UIView *touchTrackingView = [_gestureViewMap objectForKey:viewIndexNumber];
                
                //Make sure that there is a view attached to this touch and that it is a subclass of UIView.
                if ([touchTrackingView isKindOfClass:[UIView class]]) {
                    
                    //Remove it from the screen
                    [touchTrackingView removeFromSuperview];
                }
            }
            
            //Remove all objects from the hashmap after the gesture completes.
            [_gestureViewMap removeAllObjects];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            for (NSString *viewIndexNumber in _gestureViewMap) {
                
                UIView *touchTrackingView = [_gestureViewMap objectForKey:viewIndexNumber];
                
                //Make sure that there is a view attached to this touch and that it is a subclass of UIView.
                if ([touchTrackingView isKindOfClass:[UIView class]]) {
                    
                    //Remove it from the screen
                    [touchTrackingView removeFromSuperview];
                }
            }
            
            //Remove all objects from the hashmap after the gesture completes.
            [_gestureViewMap removeAllObjects];
        }
            
        default:
        {
            //Ignore other states since we don't use them in this recognizer.
        }
            break;
    }
}
@end
