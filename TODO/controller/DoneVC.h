//
//  DoneVC.h
//  TODO
//
//  Created by Aboelnaga on 12/26/19.
//  Copyright © 2019 Aboelnaga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoneVC : UIViewController<MyProtocol, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *doneTable;
@property (nonatomic, strong) NSMutableArray *toDoPendingListViewModel;
@property (weak, nonatomic) IBOutlet UISearchBar *mSearchBar;
@property (strong, nonatomic) NSMutableArray *filteredModel;

@end

NS_ASSUME_NONNULL_END
