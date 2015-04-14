//
//  Users.m
//  MojioSDKiOS
//
//  Created by Ashish Agarwal on 2015-01-27.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import "User.h"

@implementation User

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.UserName = [aDecoder decodeObjectForKey:@"UserName"];
        self.FirstName = [aDecoder decodeObjectForKey:@"FirstName"];
        self.LastName = [aDecoder decodeObjectForKey:@"LastName"];
        self.Email = [aDecoder decodeObjectForKey:@"Email"];
        self.UserCount = [aDecoder decodeFloatForKey:@"UserCount"];
        self.Credits = [aDecoder decodeFloatForKey:@"Credits"];
        self.CreationDate = [aDecoder decodeObjectForKey:@"CreationDate"];
        self.LastActivityDate = [aDecoder decodeObjectForKey:@"LastActivityDate"];
        self.LastLoginDate = [aDecoder decodeObjectForKey:@"LastLoginDate"];
        self.Locale = [aDecoder decodeObjectForKey:@"Locale"];
        self._id = [aDecoder decodeObjectForKey:@"_id"];
        self._deleted = [aDecoder decodeBoolForKey:@"_deleted"];
    }
    return self ;
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    
//    [super encodeWithCoder:aCoder]; //Do I remove this ??
    
    [aCoder encodeObject:self.UserName forKey:@"UserName"];
    [aCoder encodeObject:self.FirstName forKey:@"FirstName"];
    [aCoder encodeObject:self.LastName forKey:@"LastName"];
    [aCoder encodeObject:self.Email forKey:@"Email"];
    [aCoder encodeFloat:self.UserCount forKey:@"UserCount"];
    [aCoder encodeFloat:self.Credits forKey:@"Credits"];
    [aCoder encodeObject:self.CreationDate forKey:@"CreationDate"];
    [aCoder encodeObject:self.LastActivityDate forKey:@"LastActivityDate"];
    [aCoder encodeObject:self.LastLoginDate forKey:@"LastLoginDate"];
    [aCoder encodeObject:self.Locale forKey:@"Locale"];
    [aCoder encodeObject:self._id forKey:@"_id"];
    [aCoder encodeBool:self._deleted forKey:@"_deleted"];
}

@end


//@property (nonatomic) float Type;
//@property (nonatomic, strong) NSString *UserName;
//@property (nonatomic, strong) NSString *FirstName;
//@property (nonatomic, strong) NSString *LastName;
//@property (nonatomic, strong) NSString *Email;
//@property (nonatomic) float UserCount;
//@property (nonatomic) float Credits;
//@property (nonatomic, strong) NSString *CreationDate;
//@property (nonatomic, strong) NSString *LastActivityDate;
//@property (nonatomic, strong) NSString *LastLoginDate;
//@property (nonatomic, strong) NSString *Locale;
//@property (nonatomic, strong) NSString *_id;
//@property (nonatomic) BOOL _deleted;
