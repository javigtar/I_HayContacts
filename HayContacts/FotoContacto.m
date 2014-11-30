//
//  FotoContacto.m
//  HayContacts
//
//  Created by Javi on 30/11/14.
//  Copyright (c) 2014 javi. All rights reserved.
//

#import "FotoContacto.h"

@interface FotoContacto ()

@end

@implementation FotoContacto

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fotoContacto.image = [UIImage imageNamed:self.nombreFoto];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
