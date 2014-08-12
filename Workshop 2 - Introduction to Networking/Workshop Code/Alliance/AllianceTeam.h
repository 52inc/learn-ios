#import <Foundation/Foundation.h>

@interface AllianceTeam : NSObject <NSCoding> {

}

@property (nonatomic, strong) NSArray *allianceMembers;
@property (nonatomic, strong) NSString *allianceName;

+ (AllianceTeam *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
