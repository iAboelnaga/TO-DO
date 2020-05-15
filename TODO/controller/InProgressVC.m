//
//  InProgressVC.m
//  TODO
//
//  Created by Aboelnaga on 12/26/19.
//  Copyright © 2019 Aboelnaga. All rights reserved.
//

#import "InProgressVC.h"
#import "TodoListVC.h"
#import "AddNewTaskVC.h"
#import "TaskDetailsVC.h"
#import "TasksModel.h"
#import "TodoCell.h"
#import "EditTaskVC.h"

@interface InProgressVC ()

@end

@implementation InProgressVC
{
    TaskDetailsVC *taskD;
    TasksModel *taskM;
    EditTaskVC *editT;
    NSMutableArray *inProgArr;
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
        if (  [[[dArr objectAtIndex:i] status]isEqualToString:@"In Progress"] )
        {
            [inProgArr addObject:[dArr objectAtIndex:i]];
        }
    }
    [_inProgTable reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    taskD = [[TaskDetailsVC alloc]init];
    taskM = [[TasksModel alloc]init];
    editT = [[EditTaskVC alloc]init];
    dArr = [[NSMutableArray alloc]init];
    
    inProgArr = [[NSMutableArray alloc]init];
    def = [NSUserDefaults standardUserDefaults];
    searchResults = [[NSMutableArray alloc]init];
    
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
        
        for (id ts in inProgArr)
        {
            NSRange nameRange = [[ts fname] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound)
            {
                [searchResults addObject:ts];
                [_inProgTable reloadData];
            }
        }
        
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isFiltered) {
        return [searchResults count];
        
    } else {
        return [inProgArr count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];
    
    if (isFiltered) {
        cell.itemTitleLabel.text = [[searchResults objectAtIndex:indexPath.row]fname];
    } else {
        cell.itemTitleLabel.text = [[inProgArr objectAtIndex:indexPath.row] fname];
        if (  [[[inProgArr objectAtIndex:indexPath.row] priorty]isEqualToString:@"High"] )
        {
            cell.priortyImg.image = [UIImage imageNamed:@"high-priority"];
        }
        else if (  [[[inProgArr objectAtIndex:indexPath.row] priorty]isEqualToString:@"Low"] )
        {
            cell.priortyImg.image = [UIImage imageNamed:@"low-priority"];
        }
        else if (  [[[inProgArr objectAtIndex:indexPath.row] priorty]isEqualToString:@"Medium"] )
        {
            cell.priortyImg.image = [UIImage imageNamed:@"medium-priority"];
        }
    }
    cell.dateItemLabel.text = [[inProgArr objectAtIndex:indexPath.row] datee];
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ind = indexPath.row ;
    editT.n = [[inProgArr objectAtIndex:indexPath.row] fname];
    editT.des = [[inProgArr objectAtIndex:indexPath.row] desc];
    editT.pp = [[inProgArr objectAtIndex:indexPath.row] priorty];
    editT.s = [[inProgArr objectAtIndex:indexPath.row] status];
    
    [[self navigationController]pushViewController:editT animated:YES];
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    taskD.nameDetails = [[inProgArr objectAtIndex:indexPath.row] fname];
    taskD.descDetails = [[inProgArr objectAtIndex:indexPath.row] desc];
    taskD.priortyDetails = [[inProgArr objectAtIndex:indexPath.row] priorty];
    taskD.statusDetails = [[inProgArr objectAtIndex:indexPath.row] status];
    
    [self presentViewController:taskD animated:true completion:nil];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [inProgArr removeObjectAtIndex:indexPath.row];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:inProgArr] forKey:@"savedArray"];
        [defaults synchronize];
        
        [_inProgTable reloadData];
    }
}
- (void)editTodoData:(TasksModel*) task {
    
    [inProgArr replaceObjectAtIndex:ind withObject:task];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:inProgArr] forKey:@"savedArray"];
    [defaults synchronize];
}


@end
