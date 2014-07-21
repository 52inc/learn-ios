//
//  FTIViewController.m
//  Messages
//
//  Created by Brendan Lee on 7/19/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import "FTIViewController.h"

@interface FTIViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation FTIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _textView.inputAccessoryView = _toolbar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)closeKeyboard:(id)sender
{
    //To end textview editing.
    [_textView resignFirstResponder];
    
    //If you ever want to globally finish all editing, you can use this instead:
    //[self.view endEditing:YES];
}

-(IBAction)sendMessage:(id)sender
{
    // You MUST check if the device is configured to send messages. Devices such as iPads and iPods with iMessage disabled, or iPhones without cellular service may not be able to send messages. If you don't check this, and attempt to present the UI anyway, the controller may not be created and could cause issues with your app. In addition, on iOS versions where the controller will create and present it can cause your app to be rejected from the store.
    
    //The simulator can't send messages, so this check will fail and prevent errors in the simulator.
    if ([MFMessageComposeViewController canSendText]) {
        
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.messageComposeDelegate = self;
        
        if ([MFMessageComposeViewController canSendSubject]) {
            [controller setSubject:@"Message Project"];
        }
        else
        {
            NSLog(@"Subjects are disabled.");
        }
        
        if ([MFMessageComposeViewController canSendAttachments]) {
            
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"52inc" ofType:@"png"];
            [controller addAttachmentURL:[NSURL fileURLWithPath:filePath] withAlternateFilename:@"52inc.png"];
        }
        else
        {
            NSLog(@"Attachments are not allowed in this message.");
        }
        
        //NSString of text content. Remember, SMS messages (not iMessage) are limited in length. By brief!
        [controller setBody:_textView.text];
        
        //Array of NSStrings of phone numbers.
        [controller setRecipients:@[@"555-555-5555"]];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"This device is not configured to send messages." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

-(IBAction)sendEmail:(id)sender
{
    // You MUST check if the device is configured to send mail. Devices where the user hasn't yet setup a mail account can't send mail. If you don't check this, and attempt to present the UI anyway, the controller may not be created and could cause issues with your app. In addition, on iOS versions where the controller will create and present it can cause your app to be rejected from the store.
    
    //The simulator can't actually send mail, but it can simulate it. Not sure why it won't simulate messages, but I try to look at it as glass-half-full.
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        
        controller.mailComposeDelegate = self;
        
        [controller setSubject:@"Message Project"];
        
        [controller setToRecipients:@[@"hello@52inc.co"]];
        [controller setCcRecipients:@[@"brendan@52inc.co"]];
        [controller setBccRecipients:@[@"chris@52inc.co"]];
        
        [controller setMessageBody:_textView.text isHTML:NO];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"52inc" ofType:@"png"];
        
        [controller addAttachmentData:[NSData dataWithContentsOfFile:filePath] mimeType:@"image/png" fileName:@"52inc.png"];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"This device is not configured to send mail." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark MFMailComposeViewControllerDelegate

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //This is called when the user sends the email, or cancels. You receive a result (Cancelled, Saved, Sent, Failed). You can choose to show the user the result, but that isn't typical. If there is an error, and the user didn't cancel it, you should report it as an alert.
    
    //You are expected to dismiss the controller when this message is sent.
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableString *userInformationString = [NSMutableString string];
    
    switch (result) {
        case MFMailComposeResultCancelled:
        {
            [userInformationString appendString:@"The user cancelled this mail message."];
        }
            break;
        case MFMailComposeResultFailed:
        {
            [userInformationString appendString:@"The mail message sending failed."];
        }
            break;
        case MFMailComposeResultSaved:
        {
            [userInformationString appendString:@"This mail message was saved for later sending."];
        }
            break;
        case MFMailComposeResultSent:
        {
            [userInformationString appendString:@"This mail message was sent successfully."];
        }
            break;
    }
    
    if (error) {
        [userInformationString appendFormat:@" %@", error.localizedFailureReason];
    }
    
    //Again, unless there is an error you shouldn't bother the user with an alert. This is here for 'learning' only.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail Result" message:userInformationString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

#pragma mark MFMessageComposeViewControllerDelegate

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    //This is called when the user sends the message (SMS or iMessage), or cancels. You receive a result (Cancelled, Sent, Failed). You can choose to show the user the result, or respond to the user cancelling or failing to send the message. If it fails, you may report it as an alert. If everything succeeds, its typical to continue and not mention it to the user.
    
    //You are expected to dismiss the controller when this message is sent.
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    NSString *userInformationString;
    
    switch (result) {
        case MessageComposeResultCancelled:
        {
            userInformationString = @"The user cancelled this message.";
        }
            break;
        case MessageComposeResultFailed:
        {
            userInformationString = @"The message sending failed.";
        }
            break;
        case MessageComposeResultSent:
        {
            userInformationString = @"This message was sent successfully.";
        }
    }
    
    //Again, unless there is an error you shouldn't bother the user with an alert. This is here for 'learning' only.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message Result" message:userInformationString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
@end
