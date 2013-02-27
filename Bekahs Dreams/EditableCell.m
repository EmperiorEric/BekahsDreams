//
//  EditableCell.m
//  Bekahs Dreams
//
//  Created by Ryan Poolos on 2/26/13.
//  Copyright (c) 2013 Frozen Fire Studios. All rights reserved.
//

#import "EditableCell.h"

@interface EditableCell ()

@end

@implementation EditableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textField = [[UITextField alloc] initWithFrame:self.contentView.bounds];
        [self.textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self.textField setFont:[UIFont boldSystemFontOfSize:24.0]];
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
