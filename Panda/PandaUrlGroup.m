//
//  PandaUrlGroup.m
//  Panda
//
//  Created by usr10049697 on 2014/07/29.
//  Copyright (c) 2014年 hachijirou. All rights reserved.
//

#import "PandaUrlGroup.h"

@implementation PandaUrlGroup

- (id)init
{
    if (self = [super init]) {
        self.urlGroupList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    PandaUrlGroup *copiedObject = [[[self class] allocWithZone:zone] init];
    if (copiedObject) {
        copiedObject->_title = [_title copyWithZone:zone];
        copiedObject->_note = [_note copyWithZone:zone];
        copiedObject->_updateDate = [_updateDate copyWithZone:zone];
        copiedObject->_urlGroupList = [_urlGroupList mutableCopyWithZone:zone];
    }
    return copiedObject;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        _title = [decoder decodeObjectForKey:@"title"];
        _note = [decoder decodeObjectForKey:@"note"];
        _updateDate = [decoder decodeObjectForKey:@"updateDate"];
        _urlGroupList = [decoder decodeObjectForKey:@"urlGroupList"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_title forKey:@"title"];
    [encoder encodeObject:_note forKey:@"note"];
    [encoder encodeObject:_updateDate forKey:@"updateDate"];
    [encoder encodeObject:_urlGroupList forKey:@"urlGroupList"];
}

- (void)dealloc
{
    _title = nil;
    _note = nil;
    _updateDate =nil;
    _urlGroupList = nil;
}
@end
