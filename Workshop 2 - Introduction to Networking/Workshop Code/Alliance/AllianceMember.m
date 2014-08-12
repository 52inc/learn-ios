#import "AllianceMember.h"

@implementation AllianceMember
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.descriptionText forKey:@"descriptionText"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.profileImage forKey:@"profileImage"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.descriptionText = [decoder decodeObjectForKey:@"descriptionText"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.profileImage = [decoder decodeObjectForKey:@"profileImage"];
    }
    return self;
}

+ (AllianceMember *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    AllianceMember *instance = [[AllianceMember alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary
{

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.descriptionText = [aDictionary objectForKey:@"description"];
    self.name = [aDictionary objectForKey:@"name"];
    self.profileImage = [aDictionary objectForKey:@"profile_image"];

}

- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.descriptionText) {
        [dictionary setObject:self.descriptionText forKey:@"descriptionText"];
    }

    if (self.name) {
        [dictionary setObject:self.name forKey:@"name"];
    }

    if (self.profileImage) {
        [dictionary setObject:self.profileImage forKey:@"profileImage"];
    }

    return dictionary;

}


@end
