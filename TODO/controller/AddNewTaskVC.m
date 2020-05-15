//
//  AddNewTaskVC.m
//  TODO
//
//  Created by Aboelnaga on 12/15/19.
//  Copyright © 2019 Aboelnaga. All rights reserved.
//

#import "AddNewTaskVC.h"
#import "TasksModel.h"

@interface AddNewTaskVC ()

@end

@implementation AddNewTaskVC
{
    NSString *prop;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    prop = @"Low";
    _pp = @"Low";
    _s = @"ToDo";
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss a"];
    _d = [dateFormatter stringFromDate:[NSDate date]];
    //NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
}

- (IBAction)addPriorty:(id)sender
{
    switch (_priortySC.selectedSegmentIndex) {
        case 0:
            _pp = @"Low";
            break;
        case 1:
            _pp = @"Medium";
            break;
        case 2:
            _pp = @"High";
            break;
            
        default:
            break;
    }
}
- (IBAction)addStatus:(id)sender
{
    switch (_statusSC.selectedSegmentIndex) {
        case 0:
            _s = @"Todo";
            break;
        case 1:
            _s = @"In Progress";
            break;
        case 2:
            _s = @"Done";
            break;
            
        default:
            break;
    }
}
- (IBAction)submitAdding:(id)sender
{
    [_p changeTodoData];
    [[self navigationController]popViewControllerAnimated:YES];
}

@end
