//
//  TasksModel.m
//  TODO
//
//  Created by Aboelnaga on 12/15/19.
//  Copyright © 2019 Aboelnaga. All rights reserved.
//

#import "TasksModel.h"

@implementation TasksModel

#pragma mark - Coder Methods
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.fname forKey:@"name"];
    [encoder encodeObject:self.desc forKey:@"desc"];
    [encoder encodeObject:self.priorty forKey:@"priorty"];
    [encoder encodeObject:self.status forKey:@"status"];
    [encoder encodeObject:self.datee forKey:@"date"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init])) {
        self.fname = [decoder decodeObjectForKey:@"name"];
        self.desc = [decoder decodeObjectForKey:@"desc"];
        self.priorty = [decoder decodeObjectForKey:@"priorty"];
        self.status = [decoder decodeObjectForKey:@"status"];
        self.datee = [decoder decodeObjectForKey:@"date"];
    }
    return self;
}

#pragma mark - Init Methods
-(instancetype)initWithName:(NSString *)name Desc:(NSString *)desc Priorty:(NSString *)priorty Status:(NSString *)status Dates:(NSString *)datee
{
    self = [super init];
    if (self) {
        _fname = name;
        _desc = desc;
        _priorty = priorty;
        _status = status;
        _datee = datee;
    }
    return self;
}

@end
