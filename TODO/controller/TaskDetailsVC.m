//
//  TaskDetailsVC.m
//  TODO
//
//  Created by Aboelnaga on 12/15/19.
//  Copyright © 2019 Aboelnaga. All rights reserved.
//

#import "TaskDetailsVC.h"

@interface TaskDetailsVC ()

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *descLable;
@property (weak, nonatomic) IBOutlet UILabel *priortyLable;
@property (weak, nonatomic) IBOutlet UILabel *statusLable;

@end

@implementation TaskDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    _nameLable.text = _nameDetails;
    _descLable.text = _descDetails;
    _priortyLable.text = _priortyDetails;
    _statusLable.text = _statusDetails;
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
