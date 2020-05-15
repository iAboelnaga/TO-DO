//
//  TodoCell.h
//  TODO
//
//  Created by Aboelnaga on 12/16/19.
//  Copyright © 2019 Aboelnaga. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *priortyImg;
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateItemLabel;

@end

NS_ASSUME_NONNULL_END
