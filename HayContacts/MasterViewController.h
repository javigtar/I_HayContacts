//
//  MasterViewController.h
//  HayContacts
//
//  Created by alumno on 17/11/14.
//  Copyright (c) 2014 javi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListaContactos;

@interface MasterViewController : UITableViewController

@property (strong,nonatomic) ListaContactos *listaContactos;

- (IBAction)volver:(UIStoryboardSegue *)segue;
- (IBAction)guardar:(UIStoryboardSegue *)segue;

@end

