//
//  EditableCell.m
//  Bekahs Dreams
//
//  Created by Ryan Poolos on 2/26/13.
//  Copyright (c) 2013 Frozen Fire Studios. All rights reserved.
//

#import "UITextFieldCell.h"

@interface UITextFieldCell ()

@end

@implementation UITextFieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textField = [[UITextField alloc] initWithFrame:CGRectInset(self.contentView.bounds, 8.0, 8.0)];
        [self.textField setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [self.textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self.textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self.textField setFont:[UIFont boldSystemFontOfSize:18.0]];
        [self.textField setAdjustsFontSizeToFitWidth:YES];
        [self.textField setMinimumFontSize:12.0];
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
