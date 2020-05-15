//
//  TodoListVC.h
//  TODO
//
//  Created by Aboelnaga on 12/14/19.
//  Copyright © 2019 Aboelnaga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"

@interface TodoListVC : UIViewController<MyProtocol, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *toDoTable;
@property (nonatomic, strong) NSMutableArray *toDoPendingListViewModel;
@property (weak, nonatomic) IBOutlet UISearchBar *mSearchBar;
@property (strong, nonatomic) NSMutableArray *filteredModel;
- (IBAction)toDoNewItemBtn_Cmd:(id)sender;

@end

