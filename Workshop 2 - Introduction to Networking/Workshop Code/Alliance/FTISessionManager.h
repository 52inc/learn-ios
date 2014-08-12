//
//  FTISessionManager.h
//  Alliance
//
//  Created by Brendan Lee on 8/12/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const API_BASE = @"https://raw.githubusercontent.com/52inc/learn-ios/master/Workshop%202%20-%20Introduction%20to%20Networking/";


//Notifications
static NSString *const kFTISessionManagerDidUpdateAllianceMembers = @"kFTISessionManagerDidUpdateAllianceMembers";

@class AllianceTeam;

@interface FTISessionManager : NSObject

@property(nonatomic,strong,readonly)AllianceTeam *otherTeam;
@property(nonatomic,strong,readonly)AllianceTeam *starWarsTeam;

+(FTISessionManager*)sharedSession;

-(NSURL*)APIURLForEndpoint:(NSString*)endpoint;

-(void)updateOtherMembers;
-(void)updateStarWarsMembers;
@end
