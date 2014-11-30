//
//  MasterViewController.m
//  HayContacts
//
//  Created by alumno on 17/11/14.
//  Copyright (c) 2014 javi. All rights reserved.
//

#import "MasterViewController.h"
#import "DetalleContacto.h"
#import "ListaContactos.h"
#import "Contacto.h"
#import "NuevoContacto.h"

@interface MasterViewController ()

@property (nonatomic) NSMutableArray *objects;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.listaContactos = [[ListaContactos alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"MostrarContacto"]) {
        DetalleContacto *detalleContacto = [segue destinationViewController];
        detalleContacto.contacto = [self.listaContactos contactoSegunIndice:[self.tableView indexPathForSelectedRow].row];
    }
    
    if ([[segue identifier] isEqualToString:@"NuevoContacto"]) {
        NuevoContacto *nuevoContacto = [segue destinationViewController];
        nuevoContacto.ListaContactos = self.listaContactos;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listaContactos numeroDeContactos];
}

//Muestra en cada fila el nombre de un contacto y su imagen
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Contacto *contacto = [self.listaContactos contactoSegunIndice:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Contacto" forIndexPath:indexPath];
    
    //Asigna a foto el UIImageView de la vista con la etiqueta 1
    UIImageView *foto = (UIImageView*)[self.view viewWithTag:1];
    foto.image = contacto.imagenContacto;
    foto.layer.cornerRadius = 16;
    foto.clipsToBounds = YES;
    
    //Asigna a nombre el UILabel de la vista con la etiqueta 2
    UILabel *nombre = (UILabel*)[self.view viewWithTag:2];
    nombre.text = contacto.nombre;
     
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (IBAction)volver:(UIStoryboardSegue *)segue{
    
    if ([[segue identifier] isEqualToString:@"CancelarContacto"]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
}

- (IBAction)guardar:(UIStoryboardSegue *)segue{
    
    //Comprueba que el segue se llame GuardarContacto
    if ([[segue identifier] isEqualToString:@"GuardarContacto"]) {
        
        //Creo un puntero que hará referencia al ViewController asociado al segue
        NuevoContacto *nuevoContacto = [segue sourceViewController];
        
        //Recupero la lista de contactos con el nuevo contacto añadido
        self.listaContactos = nuevoContacto.listaContactos;
        
        //Recargo datos de la tabla
        [[self tableView] reloadData];
        
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

@end
