//
//  TodoListVC.m
//  TODO
//
//  Created by Aboelnaga on 12/14/19.
//  Copyright © 2019 Aboelnaga. All rights reserved.
//

#import "TodoListVC.h"
#import "AddNewTaskVC.h"
#import "TaskDetailsVC.h"
#import "TasksModel.h"
#import "TodoCell.h"
#import "EditTaskVC.h"

@interface TodoListVC ()

@end

@implementation TodoListVC
{
    AddNewTaskVC *addNew;
    TaskDetailsVC *taskD;
    TasksModel *taskM;
    EditTaskVC *editT;
    NSMutableArray *todoArr;
    NSMutableArray *searchResults;
    NSUserDefaults *def;
    NSData *dataRepresentingSavedArray;
    NSArray *savedArray;
    NSInteger *ind;
    Boolean *isFiltered;
    UIAlertView* alert ;
    int flag;
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
            todoArr = [[NSMutableArray alloc] initWithArray:savedArray];

        }
        else
            todoArr = [[NSMutableArray alloc] init];
    }
    [_toDoTable reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    addNew = [[AddNewTaskVC alloc]init];
    taskD = [[TaskDetailsVC alloc]init];
    taskM = [[TasksModel alloc]init];
    editT = [[EditTaskVC alloc]init];
    
    todoArr = [[NSMutableArray alloc]init];
    searchResults = [[NSMutableArray alloc]init];
    def = [NSUserDefaults standardUserDefaults];
    
    addNew = [[self storyboard]instantiateViewControllerWithIdentifier:@"AddNewTaskVC"];
    taskD = [[self storyboard]instantiateViewControllerWithIdentifier:@"TaskDetailsVC"];
    editT = [[self storyboard]instantiateViewControllerWithIdentifier:@"EditTaskVC"];
    
    [addNew setP:self];
    [editT setP:self];
    _mSearchBar.delegate = self;
    
    flag = 0 ;
}

-(void)toDoNewItemBtn_Cmd:(id)sender
{
    [[self navigationController]pushViewController:addNew animated:YES];
}
//- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
//{
//    NSPredicate *resultPredicate = [NSPredicate
//                                    predicateWithFormat:@"SELF contains[cd] %@",
//                                    searchText];
//    
//    searchResults = [todoArr filteredArrayUsingPredicate:resultPredicate];
//}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText  isEqual: @""]){
        isFiltered = false;
    }
    else
    {
        isFiltered = true;
        
        for (id ts in todoArr)
        {
            NSRange nameRange = [[ts fname] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound)
            {
                [searchResults addObject:ts];
                [_toDoTable reloadData];
            }
        }
        
        
    }
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    isFiltered = false;
    [_toDoTable reloadData];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if(buttonIndex == 0  )
        {
            flag = 1;
        }
        else
        {
            flag = 0;
        }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isFiltered) {
        return [searchResults count];
        
    } else {
        return [todoArr count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];
    
    if (isFiltered) {
        cell.itemTitleLabel.text = [[searchResults objectAtIndex:indexPath.row]fname];
    } else {
    cell.itemTitleLabel.text = [[todoArr objectAtIndex:indexPath.row] fname];
        if (  [[[todoArr objectAtIndex:indexPath.row] priorty]isEqualToString:@"High"] )
        {
            cell.priortyImg.image = [UIImage imageNamed:@"high-priority"];
        }
        else if (  [[[todoArr objectAtIndex:indexPath.row] priorty]isEqualToString:@"Low"] )
        {
            cell.priortyImg.image = [UIImage imageNamed:@"low-priority"];
        }
        else if (  [[[todoArr objectAtIndex:indexPath.row] priorty]isEqualToString:@"Medium"] )
        {
            cell.priortyImg.image = [UIImage imageNamed:@"medium-priority"];
        }
    }
    cell.dateItemLabel.text = [[todoArr objectAtIndex:indexPath.row] datee];
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ind = indexPath.row ;
    editT.n = [[todoArr objectAtIndex:indexPath.row] fname];
    editT.des = [[todoArr objectAtIndex:indexPath.row] desc];
    editT.pp = [[todoArr objectAtIndex:indexPath.row] priorty];
    editT.s = [[todoArr objectAtIndex:indexPath.row] status];
    
    [[self navigationController]pushViewController:editT animated:YES];
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    taskD.nameDetails = [[todoArr objectAtIndex:indexPath.row] fname];
    taskD.descDetails = [[todoArr objectAtIndex:indexPath.row] desc];
    taskD.priortyDetails = [[todoArr objectAtIndex:indexPath.row] priorty];
    taskD.statusDetails = [[todoArr objectAtIndex:indexPath.row] status];
    
    [self presentViewController:taskD animated:true completion:nil];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Are You Sure?" delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"No", nil];
        [alert setAlertViewStyle:UIAlertViewStyleDefault];
        [alert show];
        
        if (flag == 1)
        {
            [todoArr removeObjectAtIndex:indexPath.row];
        
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:todoArr] forKey:@"savedArray"];
            [defaults synchronize];
        
            [_toDoTable reloadData];
            flag = 0;
        }
    }
}
- (void)changeTodoData {

    TasksModel *task = [[TasksModel alloc]initWithName:[[addNew nameTF] text] Desc:[[addNew descTF] text] Priorty:[addNew pp] Status:[addNew s] Dates:[addNew d]];
    
        [todoArr addObject:task];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:todoArr] forKey:@"savedArray"];
        [defaults synchronize];
}
- (void)editTodoData:(TasksModel*) task {
    
    [todoArr replaceObjectAtIndex:ind withObject:task];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:todoArr] forKey:@"savedArray"];
    [defaults synchronize];
}

@end
