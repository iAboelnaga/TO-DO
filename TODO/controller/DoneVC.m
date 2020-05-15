//
//  DoneVC.m
//  TODO
//
//  Created by Aboelnaga on 12/26/19.
//  Copyright © 2019 Aboelnaga. All rights reserved.
//

#import "DoneVC.h"
#import "TodoListVC.h"
#import "AddNewTaskVC.h"
#import "TaskDetailsVC.h"
#import "TasksModel.h"
#import "TodoCell.h"
#import "EditTaskVC.h"

@interface DoneVC ()

@end

@implementation DoneVC
{
    TaskDetailsVC *taskD;
    TasksModel *taskM;
    EditTaskVC *editT;
    NSMutableArray *doneArr;
    NSMutableArray *dArr;
    NSMutableArray *searchResults;
    NSUserDefaults *def;
    NSData *dataRepresentingSavedArray;
    NSArray *savedArray;
    NSInteger *ind;
    Boolean *isFiltered;
}
- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    dataRepresentingSavedArray = [currentDefaults objectForKey:@"savedArray"];
    //NSMutableArray *objectArray = nil;
    
    if (dataRepresentingSavedArray != nil)
    {
        savedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (savedArray != nil)
        {
            dArr = [[NSMutableArray alloc] initWithArray:savedArray];
            
        }
        else
            dArr = [[NSMutableArray alloc] init];
    }
    
    for (int i=0; i< dArr.count;i++)
    {
        if (  [[[dArr objectAtIndex:i] status]isEqualToString:@"Done"] )
        {
            [doneArr addObject:[dArr objectAtIndex:i]];
        }
    }
    
    [_doneTable reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    taskD = [[TaskDetailsVC alloc]init];
    taskM = [[TasksModel alloc]init];
    editT = [[EditTaskVC alloc]init];
    
    doneArr = [[NSMutableArray alloc]init];
    def = [NSUserDefaults standardUserDefaults];
    
    taskD = [[self storyboard]instantiateViewControllerWithIdentifier:@"TaskDetailsVC"];
    editT = [[self storyboard]instantiateViewControllerWithIdentifier:@"EditTaskVC"];
    
    [editT setP:self];
    _mSearchBar.delegate = self;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText  isEqual: @""]){
        isFiltered = false;
    }
    else
    {
        isFiltered = true;
        
        for (id ts in doneArr)
        {
            NSRange nameRange = [[ts fname] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound)
            {
                [searchResults addObject:ts];
                [_doneTable reloadData];
            }
        }
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isFiltered) {
        return [searchResults count];
        
    } else {
        return [doneArr count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];
    
    if (isFiltered) {
        cell.itemTitleLabel.text = [[searchResults objectAtIndex:indexPath.row]name];
    } else {
        cell.itemTitleLabel.text = [[doneArr objectAtIndex:indexPath.row] fname];
        if (  [[[doneArr objectAtIndex:indexPath.row] priorty]isEqualToString:@"High"] )
        {
            cell.priortyImg.image = [UIImage imageNamed:@"high-priority"];
        }
        else if (  [[[doneArr objectAtIndex:indexPath.row] priorty]isEqualToString:@"Low"] )
        {
            cell.priortyImg.image = [UIImage imageNamed:@"low-priority"];
        }
        else if (  [[[doneArr objectAtIndex:indexPath.row] priorty]isEqualToString:@"Medium"] )
        {
            cell.priortyImg.image = [UIImage imageNamed:@"medium-priority"];
        }
    }
    cell.dateItemLabel.text = [[doneArr objectAtIndex:indexPath.row] datee];
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ind = indexPath.row ;
    editT.n = [[doneArr objectAtIndex:indexPath.row] fname];
    editT.des = [[doneArr objectAtIndex:indexPath.row] desc];
    editT.pp = [[doneArr objectAtIndex:indexPath.row] priorty];
    editT.s = [[doneArr objectAtIndex:indexPath.row] status];
    
    [[self navigationController]pushViewController:editT animated:YES];
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    taskD.nameDetails = [[doneArr objectAtIndex:indexPath.row] fname];
    taskD.descDetails = [[doneArr objectAtIndex:indexPath.row] desc];
    taskD.priortyDetails = [[doneArr objectAtIndex:indexPath.row] priorty];
    taskD.statusDetails = [[doneArr objectAtIndex:indexPath.row] status];
    
    [self presentViewController:taskD animated:true completion:nil];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [doneArr removeObjectAtIndex:indexPath.row];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:doneArr] forKey:@"savedArray"];
        [defaults synchronize];
        
        [_doneTable reloadData];
    }
}
- (void)editTodoData:(TasksModel*) task {
    
    [doneArr replaceObjectAtIndex:ind withObject:task];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:doneArr] forKey:@"savedArray"];
    [defaults synchronize];
}

@end
