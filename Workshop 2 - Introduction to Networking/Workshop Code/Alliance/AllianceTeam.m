#import "AllianceTeam.h"

#import "AllianceMember.h"

@implementation AllianceTeam
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.allianceMembers forKey:@"allianceMembers"];
    [encoder encodeObject:self.allianceName forKey:@"allianceName"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.allianceMembers = [decoder decodeObjectForKey:@"allianceMembers"];
        self.allianceName = [decoder decodeObjectForKey:@"allianceName"];
    }
    return self;
}

+ (AllianceTeam *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    AllianceTeam *instance = [[AllianceTeam alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary
{

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }


    NSArray *receivedAllianceMembers = [aDictionary objectForKey:@"alliance_members"];
    if ([receivedAllianceMembers isKindOfClass:[NSArray class]]) {

        NSMutableArray *populatedAllianceMembers = [NSMutableArray arrayWithCapacity:[receivedAllianceMembers count]];
        for (NSDictionary *item in receivedAllianceMembers) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [populatedAllianceMembers addObject:[AllianceMember instanceFromDictionary:item]];
            }
        }

        self.allianceMembers = populatedAllianceMembers;

    }
    self.allianceName = [aDictionary objectForKey:@"alliance_name"];

}

- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.allianceMembers) {
        [dictionary setObject:self.allianceMembers forKey:@"allianceMembers"];
    }

    if (self.allianceName) {
        [dictionary setObject:self.allianceName forKey:@"allianceName"];
    }

    return dictionary;

}


@end
