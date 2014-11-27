//
//  DetalleContacto.m
//  HayContacts
//
//  Created by alumno on 19/11/14.
//  Copyright (c) 2014 javi. All rights reserved.
//

#import "DetalleContacto.h"
#import "Contacto.h"
#import "NuevoContacto.h"

@interface DetalleContacto ()

@end

@implementation DetalleContacto

-(void)setContacto:(Contacto *)nuevoContacto{
    if(_contacto != nuevoContacto){
        _contacto = nuevoContacto;
        
        //Update the view.
        [self mostrarDetalle];
    }
}


- (void)viewDidLoad {
   [super viewDidLoad];
    [self mostrarDetalle];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mostrarDetalle{
    
    Contacto *contacto = self.contacto;
    
    if (contacto) {
        NSString *nombreCompleto = [[NSString alloc] initWithFormat:@"%@ %@", self.contacto.nombre, self.contacto.apellidos];
        self.nombre.text = nombreCompleto;
        self.imagen.image = self.contacto.imagenContacto;
        self.telefono.text = [self.contacto.telefono stringValue];
        self.direccion.text = self.contacto.direccion;
        self.grupo.text = self.contacto.grupo;
        self.mail.text = self.contacto.mail;
        self.twitter.text = self.contacto.twitter;
        self.facebook.text = self.contacto.facebook;
        [self.whatsapp setOn:self.contacto.whatsapp];
        //self.whatsapp.text = self.contacto.whatsapp;
        //Imagen del contacto redondeada
        self.imagen.layer.cornerRadius = 40;
        self.imagen.clipsToBounds = YES;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 8;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //Compruebo que el segue se llame EditarContacto
    if ([[segue identifier] isEqualToString:@"EditarContacto"]) {
        NuevoContacto *editarContacto = [segue destinationViewController];
        editarContacto.contacto = self.contacto;
    }
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
