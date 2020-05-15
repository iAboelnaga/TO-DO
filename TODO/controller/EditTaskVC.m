//
//  EditTaskVC.m
//  TODO
//
//  Created by Aboelnaga on 12/22/19.
//  Copyright © 2019 Aboelnaga. All rights reserved.
//

#import "EditTaskVC.h"

@interface EditTaskVC ()

@end

@implementation EditTaskVC
{
    NSString *prop;
    TasksModel *t;
}
-(void)viewWillAppear:(BOOL)animated{
    _nameTF.text = _n;
    _descTF.text = _des;
    
    if([_s  isEqual: @"Low"]){
        _priortySC.selectedSegmentIndex = 0;
    }
    else if([_s  isEqual: @"Medium"]){
        _priortySC.selectedSegmentIndex = 1;
    }
    else if([_s  isEqual: @"High"]){
        _priortySC.selectedSegmentIndex = 2;
    }
    
    if([_s  isEqual: @"Todo"]){
        _statusSC.selectedSegmentIndex = 0;
    }
    else if([_s  isEqual: @"In Progress"]){
        _statusSC.selectedSegmentIndex = 1;
    }
    else if([_s  isEqual: @"Done"]){
        _statusSC.selectedSegmentIndex = 2;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    prop = @"Low";
    _pp = @"Low";
    _s = @"ToDo";
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss a"];
    _d = [dateFormatter stringFromDate:[NSDate date]];
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
    t = [[TasksModel alloc]initWithName:[_nameTF text] Desc:[_descTF text] Priorty:_pp Status:_s Dates:_d];
    [_p editTodoData:t];
    [[self navigationController]popViewControllerAnimated:YES];
}
@end
