//
//  TasksModel.h
//  TODO
//
//  Created by Aboelnaga on 12/15/19.
//  Copyright © 2019 Aboelnaga. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TasksModel : NSObject

@property NSString* fname;
@property NSString* desc;
@property NSString* priorty;
@property NSString* status;
@property NSString* datee;

- (instancetype)initWithName:(NSString*)name Desc:(NSString*)desc Priorty:(NSString*)priorty Status:(NSString*)status Dates:(NSString*)datee;

@end

NS_ASSUME_NONNULL_END
