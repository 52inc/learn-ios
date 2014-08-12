//
//  FTIAllianceContactTableViewController.m
//  Alliance
//
//  Created by Brendan Lee on 7/8/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import "FTIAllianceContactTableViewController.h"

#import "FTIAllianceProfile.h"

#import "AllianceTeam.h"
#import "AllianceMember.h"

#define AllianceContactListMembersSection 0
#define AllianceContactListFriendsSection 1

#define AllianceAddPersonAlertView 101

@interface FTIAllianceContactTableViewController ()

@property(nonatomic,strong)NSArray *allianceMembers;
@property(nonatomic,strong)NSMutableArray *allianceFriends;

@property(nonatomic,assign)BOOL isStarWarsAlliance;

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
        
        _isStarWarsAlliance = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Swap" style:UIBarButtonItemStyleBordered target:self action:@selector(swapTeams:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPerson:)];
    
    self.tableView.separatorColor = [UIColor allianceCellDividerColor];
    self.tableView.backgroundColor = [UIColor allianceCellBackgroundColor];
    
    //We need to setup a listener for when the Session Manager updates
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataSource) name:kFTISessionManagerDidUpdateAllianceMembers object:nil];
    
    [self reloadDataSource];
}

-(void)swapTeams:(id)sender
{
    _isStarWarsAlliance = !_isStarWarsAlliance;
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

-(void)reloadDataSource
{
    if (_isStarWarsAlliance) {
        
        AllianceTeam *team = [[FTISessionManager sharedSession] allianceFighters];
        
        _allianceMembers = [team allianceMembers];
        
        if (team.allianceName) {
            self.title = team.allianceName;
        }
        else
        {
            self.title = @"The Alliance";
        }
    }
    else
    {
        AllianceTeam *team = [[FTISessionManager sharedSession] empireFighters];
        
        _allianceMembers = [team allianceMembers];
        
        if (team.allianceName) {
            self.title = team.allianceName;
        }
        else
        {
            self.title = @"The Empire";
        }
    }

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
    
    cell.imageView.image = nil;
    cell.textLabel.text = nil;
    cell.detailTextLabel.text = nil;
    
    if (_isStarWarsAlliance) {
        cell.textLabel.textColor = [UIColor allianceTitleColor];
    }
    else
    {
        cell.textLabel.textColor = [UIColor empireTitleColor];
    }
    
    switch (indexPath.section) {
        case AllianceContactListMembersSection:
        {
            AllianceMember * currentProfile = _allianceMembers[indexPath.row];
            
            cell.textLabel.text = currentProfile.name;
            cell.detailTextLabel.text = currentProfile.descriptionText;
            
            cell.imageView.image = nil;
            
            //Asynchronous network images! NOTE: There are tons of libraries to do this better and cache more efficiently.
            [[[NSURLSession sharedSession] dataTaskWithURL:[[FTISessionManager sharedSession] APIURLForEndpoint:currentProfile.profileImage] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               
                UIImage *image = [UIImage imageWithData:data scale:2.0];
                
                if (image && !cell.imageView.image) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell.imageView setImage:image];
                        [cell setNeedsLayout];
                    });
                }
            }] resume];
        }
            break;
        case AllianceContactListFriendsSection:
        {
            FTIAllianceProfile *currentProfile = _allianceFriends[indexPath.row];
            
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
            break;
        default:

        {
            cell.imageView.image = nil;
            cell.textLabel.text = nil;
            cell.detailTextLabel.text = nil;
        }
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
    if (indexPath.section == AllianceContactListFriendsSection) {
        return YES;
    }
    
    return NO;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        if (indexPath.section == AllianceContactListFriendsSection) {
            [_allianceFriends removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
}

@end
