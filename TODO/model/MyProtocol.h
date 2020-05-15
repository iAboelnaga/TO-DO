//
//  MyProtocol.h
//  TODO
//
//  Created by Aboelnaga on 12/15/19.
//  Copyright © 2019 Aboelnaga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TasksModel.h"


@protocol MyProtocol <NSObject>

-(void)changeTodoData;
-(void)editTodoData:(TasksModel*) task;

@end
