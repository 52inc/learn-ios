//
//  FTISessionManager.m
//  Alliance
//
//  Created by Brendan Lee on 8/12/14.
//  Copyright (c) 2014 52inc. All rights reserved.
//

#import "FTISessionManager.h"

#import "AllianceMember.h"
#import "AllianceTeam.h"

static FTISessionManager *sharedSesson;

@implementation FTISessionManager

//Because we overrode the getter, auto-synthesis didn't have anything to generate. We need to manually synthesize the instance variable version of our properties like we used to in the olden' days.
@synthesize empireFighters = _empireFighters;
@synthesize allianceFighters = _allianceFighters;

/**
 *  Generate / retreive the singleton instance of the SessionManager
 *
 *  @return The singleton instance of the Session Manager.
 */
+(FTISessionManager*)sharedSession
{
    if (!sharedSesson) {
        sharedSesson = [[self alloc] init];
    }
    
    return sharedSesson;
}

/**
 *  Generate a URL for the API given a resource location on the endpoint.
 *
 *  @param endpoint The resource you're wanting to locate.
 *
 *  @return The API to locate the resource.
 */
-(NSURL*)APIURLForEndpoint:(NSString*)endpoint
{
    return [NSURL URLWithString:[API_BASE stringByAppendingPathComponent:endpoint]];
}

/**
 *  Retrieve the members of The Empire team. Load them if not already loaded from the network.
 *
 *  @return An array of the other team's members.
 */
-(AllianceTeam *)empireFighters{
    
    if (!_empireFighters) {
        //Fetch other members
        [self updateEmpireFighters];
    }
    
    return _empireFighters;
}

/**
 *  Retrieve the members of The Alliance team. Load them if not already loaded from the network.
 *
 *  @return An array of the Star Wars members.
 */
-(AllianceTeam *)allianceFighters{
    
    if (!_allianceFighters) {
        //Fetch Star Wars members
        [self updateAllianceFighters];
    }
    
    return _allianceFighters;
}

/**
 *  Update the Empire Fighters to the latest version of them from the web server.
 */
-(void)updateEmpireFighters {
    
    NSURL *url = [self APIURLForEndpoint:@"EmpireMembers.json"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       
        if (!error) {
            //Parse JSON
            NSError *jsonError;
            
            NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (!jsonError) {
                //Parse this into a real AllianceTeam, or update an existing one.
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!_empireFighters) {
                        _empireFighters = [AllianceTeam instanceFromDictionary:parsedJSON];
                    }
                    else
                    {
                        [_empireFighters setAttributesFromDictionary:parsedJSON];
                    }
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kFTISessionManagerDidUpdateAllianceMembers object:nil];
                });
            }
            else
            {
                NSLog(@"JSON The Empire error: %@", jsonError.localizedDescription);
            }
        }
        else
        {
            NSLog(@"The Empire error: %@", error.localizedDescription);
        }
    }] resume];
    
}

/**
 *  Update the Alliance Fighters to the latest version of them from the web server.
 */
-(void)updateAllianceFighters {
    
    NSURL *url = [self APIURLForEndpoint:@"AllianceMembers.json"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            //Parse JSON
            NSError *jsonError;
            
            NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (!jsonError) {
                //Parse this into a real AllianceTeam, or update an existing one.
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!_empireFighters) {
                        _allianceFighters = [AllianceTeam instanceFromDictionary:parsedJSON];
                    }
                    else
                    {
                        [_allianceFighters setAttributesFromDictionary:parsedJSON];
                    }
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kFTISessionManagerDidUpdateAllianceMembers object:nil];
                });
            }
            else
            {
                NSLog(@"JSON The Alliance members error: %@", jsonError.localizedDescription);
            }
        }
        else
        {
            NSLog(@"The Alliance members error: %@", error.localizedDescription);
        }
    }] resume];
}

@end
