//
//  FTIAllianceContactTableViewController.m
//  Alliance
//
//  Created by Brendan Lee on 7/8/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import "FTIAllianceContactTableViewController.h"
#import "FTIAllianceProfile.h"

#define AllianceContactListMembersSection 0
#define AllianceContactListFriendsSection 1

#define AllianceAddPersonAlertView 101
#define AllianceModifyPersonAlertView 102

@interface FTIAllianceContactTableViewController ()

@property(nonatomic,strong)NSMutableArray *allianceMembers;
@property(nonatomic,strong)NSMutableArray *allianceFriends;

@property(nonatomic,strong)FTIAllianceProfile *profileBeingEdited;

@end

@implementation FTIAllianceContactTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"The Alliance";
        _allianceFriends = [NSMutableArray array];
        _allianceMembers = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPerson:)];
    
    self.tableView.separatorColor = [UIColor allianceCellDividerColor];
    self.tableView.backgroundColor = [UIColor allianceCellBackgroundColor];
    
    [self reloadDataSource];
}

-(void)addPerson:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Alliance" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    alert.tag = AllianceAddPersonAlertView;
    
    //Disable password entry...
    [[alert textFieldAtIndex:1] setSecureTextEntry:NO];
    
    //Enable prompts
    [[alert textFieldAtIndex:0] setPlaceholder:@"Name"];
    [[alert textFieldAtIndex:1] setPlaceholder:@"Description"];
    
    [alert show];
}

-(void)modifyPersonAtIndexPath:(NSIndexPath*)index
{
    switch (index.section) {
        case AllianceContactListMembersSection:
        {
            _profileBeingEdited = _allianceMembers[index.row];
        }
            break;
        case AllianceContactListFriendsSection:
        {
            _profileBeingEdited = _allianceFriends[index.row];
        }
    }
    
    if (_profileBeingEdited) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Modify Alliance" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
        
        alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        alert.tag = AllianceModifyPersonAlertView;
        
        //Disable password entry...
        [[alert textFieldAtIndex:1] setSecureTextEntry:NO];
        
        //Enable prompts
        [[alert textFieldAtIndex:0] setPlaceholder:@"Name"];
        [[alert textFieldAtIndex:1] setPlaceholder:@"Description"];
        
        [[alert textFieldAtIndex:0] setText:_profileBeingEdited.name];
        [[alert textFieldAtIndex:1] setText:_profileBeingEdited.profileDescription];
        
        [alert show];
    }
}

-(void)reloadDataSource
{
    NSDictionary *alliance = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AllianceMembers" ofType:@"json"]] options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *allianceJSON = alliance[@"alliance_members"];
    
    NSMutableArray *allianceMembersTemp = [NSMutableArray array];
    
    for (NSDictionary *currentMember in allianceJSON) {
        [allianceMembersTemp addObject:[[FTIAllianceProfile alloc] initWithDictionary:currentMember]];
    }
    _allianceMembers = allianceMembersTemp;
    
    NSArray *allianceFriendsJSON = alliance[@"alliance_friends"];
    
    NSMutableArray *allianceFriendsTemp = [NSMutableArray array];
    
    for (NSDictionary *currentMember in allianceFriendsJSON) {
        [allianceFriendsTemp addObject:[[FTIAllianceProfile alloc] initWithDictionary:currentMember]];
    }
    _allianceFriends = allianceFriendsTemp;
                        
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    switch (section) {
        case AllianceContactListMembersSection:
        {
            return _allianceMembers.count;
        }
            break;
        case AllianceContactListFriendsSection:
        {
            return  _allianceFriends.count;
        }
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        //A cell wasn't dequeue'd, so we need to create one.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        //Configure its appearance. Do it inside the creation case so it will only run once.
        cell.textLabel.font = [UIFont allianceTitleFont];
        cell.textLabel.textColor = [UIColor allianceTitleColor];
        
        cell.detailTextLabel.font = [UIFont allianceSubtitleFont];
        cell.detailTextLabel.textColor = [UIColor allianceSubtitleColor];

        cell.backgroundView = [UIView new];
        cell.selectedBackgroundView = [UIView new];
        
        cell.backgroundView.backgroundColor = [UIColor allianceCellBackgroundColor];
        cell.selectedBackgroundView.backgroundColor = [UIColor allianceCellHighlightBackgroundColor];
        
        cell.separatorInset = UIEdgeInsetsMake(0.0, 16.0, 0.0, 0.0);
        
        //Fallback
        cell.backgroundColor = [UIColor allianceCellBackgroundColor];
    }
    
    FTIAllianceProfile *currentProfile;
    
    switch (indexPath.section) {
        case AllianceContactListMembersSection:
        {
            currentProfile = _allianceMembers[indexPath.row];
        }
            break;
        case AllianceContactListFriendsSection:
        {
            currentProfile = _allianceFriends[indexPath.row];
        }
    }
    
    if (currentProfile) {
        if (currentProfile.profileImage.length > 0) {
            cell.imageView.image = [UIImage imageNamed:currentProfile.profileImage];
        }
        else
        {
            cell.imageView.image = [FTIAllianceProfile profilePlaceholderForName:currentProfile.name withSize:CGSizeMake(44.0, 44.0)];
        }
        
        cell.textLabel.text = currentProfile.name;
        cell.detailTextLabel.text = currentProfile.profileDescription;
    }
    else
    {
        cell.imageView.image = nil;
        cell.textLabel.text = nil;
        cell.detailTextLabel.text = nil;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.0;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        switch (indexPath.section) {
            case AllianceContactListMembersSection:
            {
                [_allianceMembers removeObjectAtIndex:indexPath.row];
            }
                break;
            case AllianceContactListFriendsSection:
            {
                [_allianceFriends removeObjectAtIndex:indexPath.row];
            }
                break;
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    FTIAllianceProfile *movedProfile;
    
    //Remove from older data source section
    switch (fromIndexPath.section) {
        case AllianceContactListMembersSection:
        {
            movedProfile = _allianceMembers[fromIndexPath.row];
            [_allianceMembers removeObject:movedProfile];
        }
            break;
        case AllianceContactListFriendsSection:
        {
            movedProfile = _allianceFriends[fromIndexPath.row];
            [_allianceFriends removeObject:movedProfile];
        }
            break;
    }
    
    if (movedProfile) {
        switch (toIndexPath.section) {
            case AllianceContactListMembersSection:
            {
                [_allianceMembers insertObject:movedProfile atIndex:toIndexPath.row];
            }
                break;
            case AllianceContactListFriendsSection:
            {
                [_allianceFriends insertObject:movedProfile atIndex:toIndexPath.row];
            }
                break;
        }
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, [self tableView:tableView heightForHeaderInSection:section])];
    
    sectionHeaderView.backgroundColor = [UIColor allianceCellDividerColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.separatorInset.left, 0.0, sectionHeaderView.bounds.size.width-tableView.separatorInset.left, sectionHeaderView.bounds.size.height)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont allianceSectionHeaderFont];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    
    [sectionHeaderView addSubview:titleLabel];
    
    switch (section) {
        case AllianceContactListMembersSection:
        {
            titleLabel.text = @"Members";
        }
            break;
        case AllianceContactListFriendsSection:
        {
            titleLabel.text = @"Friends";
        }
            break;
    }
    
    return sectionHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22.0;
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self modifyPersonAtIndexPath:indexPath];
}

#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == AllianceAddPersonAlertView) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            
            FTIAllianceProfile *newProfile = [[FTIAllianceProfile alloc] init];
            newProfile.name = [[alertView textFieldAtIndex:0] text] ? [[alertView textFieldAtIndex:0] text] : @"";
            newProfile.profileDescription = [[alertView textFieldAtIndex:1] text] ? [[alertView textFieldAtIndex:1] text] : @"";
            
            [_allianceFriends addObject:newProfile];
            
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_allianceFriends.count-1 inSection:AllianceContactListFriendsSection]] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    
    if (alertView.tag == AllianceModifyPersonAlertView) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            
            _profileBeingEdited.name = [[alertView textFieldAtIndex:0] text] ? [[alertView textFieldAtIndex:0] text] : @"";
            _profileBeingEdited.profileDescription = [[alertView textFieldAtIndex:1] text];
            
            [self.tableView reloadData];
        }

    }
}

@end
