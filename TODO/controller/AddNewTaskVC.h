//
//  AddNewTaskVC.h
//  TODO
//
//  Created by Aboelnaga on 12/15/19.
//  Copyright © 2019 Aboelnaga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "TasksModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddNewTaskVC : UIViewController<MyProtocol>

@property (weak, nonatomic) IBOutlet UISegmentedControl *priortySC;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *descTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSC;
- (IBAction)submitAdding:(id)sender;

@property id<MyProtocol>p;
@property NSString *pp;
@property NSString *s;
@property NSString *d;

@end

NS_ASSUME_NONNULL_END
