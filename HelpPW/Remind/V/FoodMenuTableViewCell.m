//
//  FoodMenuTableViewCell.m
//  HelpPW
//
//  Created by 何亚运 on 16/3/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "FoodMenuTableViewCell.h"
#import "FoodCustomTableViewCell.h"
@interface FoodMenuTableViewCell ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView *tabelV;
@end

@implementation FoodMenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *bgL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 5)];
        bgL.backgroundColor = [UIColor qianweise];
        bgL.alpha = 0.6;
        [self.contentView addSubview:bgL];
        
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kWidth/12, kWidth/12)];
        _imageV.image = [UIImage imageNamed:@"shipu@2x.png"];
        [self.contentView addSubview:self.imageV];
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(self.imageV.frame.origin.x+self.imageV.bounds.size.width+10, self.imageV.frame.origin.y, kWidth-30-self.imageV.bounds.size.width, self.imageV.bounds.size.height)];
        titleL.text = @"本周食谱";
        titleL.textColor = [UIColor qianweise];
        [self.contentView addSubview:titleL];
        
        self.tabelV = [[UITableView alloc] initWithFrame:CGRectMake(self.imageV.frame.origin.x, self.imageV.frame.origin.y+self.imageV.bounds.size.height+10, kWidth-20, kWidth/2+40) style:UITableViewStylePlain];
        self.tabelV.scrollEnabled = NO;
        self.tabelV.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tabelV.dataSource = self;
        self.tabelV.delegate = self;
        [self.contentView addSubview:self.tabelV];
        
        
    }
    return self;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[FoodCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    NSDictionary *dict = _arr[indexPath.row];
    cell.imageV.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    cell.titleL.text = [dict objectForKey:@"name"];
    cell.desL.text = [dict objectForKey:@"effect"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = _arr[indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(passFoodInfo:)]) {
        [_delegate passFoodInfo:dict];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth/8+10;
}

- (void)setArr:(NSMutableArray *)arr {
    _arr = arr;
    [self.tabelV reloadData];
}



@end
