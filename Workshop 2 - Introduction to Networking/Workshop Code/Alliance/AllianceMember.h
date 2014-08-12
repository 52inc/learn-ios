#import <Foundation/Foundation.h>

@interface AllianceMember : NSObject <NSCoding> {

}

@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *profileImage;

+ (AllianceMember *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
