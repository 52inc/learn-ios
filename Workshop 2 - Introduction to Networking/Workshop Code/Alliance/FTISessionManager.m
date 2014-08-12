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
@synthesize otherTeam = _otherTeam;
@synthesize starWarsTeam = _starWarsTeam;

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
 *  Retrieve the members of the other team. Load them if not already loaded from the network.
 *
 *  @return An array of the other team's members.
 */
-(AllianceTeam *)otherTeam{
    
    if (!_otherTeam) {
        //Fetch other members
        [self updateOtherMembers];
    }
    
    return _otherTeam;
}

/**
 *  Retrieve the members of the Star Wars team. Load them if not already loaded from the network.
 *
 *  @return An array of the Star Wars members.
 */
-(AllianceTeam *)starWarsTeam{
    
    if (!_starWarsTeam) {
        //Fetch Star Wars members
        [self updateStarWarsMembers];
    }
    
    return _starWarsTeam;
}

/**
 *  Update the Other Members to the latest version of them from the web server.
 */
-(void)updateOtherMembers {
    
    NSURL *url = [self APIURLForEndpoint:@"StarWarsMembers.json"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       
        if (!error) {
            //Parse JSON
            NSError *jsonError;
            
            NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (!jsonError) {
                //Parse this into a real AllianceTeam, or update an existing one.
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!_otherTeam) {
                        _otherTeam = [AllianceTeam instanceFromDictionary:parsedJSON];
                    }
                    else
                    {
                        [_otherTeam setAttributesFromDictionary:parsedJSON];
                    }
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kFTISessionManagerDidUpdateAllianceMembers object:nil];
                });
            }
            else
            {
                NSLog(@"JSON Other members error: %@", jsonError.localizedDescription);
            }
        }
        else
        {
            NSLog(@"Other members error: %@", error.localizedDescription);
        }
    }] resume];
    
}

/**
 *  Update the Star Wars members to the lateste version of them from the web server.
 */
-(void)updateStarWarsMembers {
    
    NSURL *url = [self APIURLForEndpoint:@"StarWarsMembers.json"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            //Parse JSON
            NSError *jsonError;
            
            NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (!jsonError) {
                //Parse this into a real AllianceTeam, or update an existing one.
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!_otherTeam) {
                        _starWarsTeam = [AllianceTeam instanceFromDictionary:parsedJSON];
                    }
                    else
                    {
                        [_starWarsTeam setAttributesFromDictionary:parsedJSON];
                    }
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kFTISessionManagerDidUpdateAllianceMembers object:nil];
                });
            }
            else
            {
                NSLog(@"JSON Star Wars members error: %@", jsonError.localizedDescription);
            }
        }
        else
        {
            NSLog(@"Star Wars members error: %@", error.localizedDescription);
        }
    }] resume];
}

@end
