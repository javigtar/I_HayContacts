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
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"MostrarContacto"]) {
        DetalleContacto *detalleContacto = [segue destinationViewController];
        detalleContacto.contacto = [self.listaContactos contactoSegunIndice:[self.tableView indexPathForSelectedRow].row];      

    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listaContactos numeroDeContactos];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Contacto *contacto = [self.listaContactos contactoSegunIndice:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Contacto" forIndexPath:indexPath];
    
    //[cell.textLabel setText:contacto.nombre];
    
    //cell.imageView.image = contacto.imagenContacto;
   
    //[cell.imageView setAutoresizingMask:UIViewAutoresizingNone];
     
    //cell.imageView.layer.cornerRadius = 20;
    //cell.imageView.clipsToBounds = YES;
    
    
    UIImageView *foto = (UIImageView*)[self.view viewWithTag:1];
    foto.image = contacto.imagenContacto;
    foto.layer.cornerRadius = 16;
    foto.clipsToBounds = YES;
    
    UILabel *nombre = (UILabel*)[self.view viewWithTag:2];
    nombre.text = contacto.nombre;
    
    
    
     
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (IBAction)volver:(UIStoryboardSegue *)segue{
    
    if ([[segue identifier] isEqualToString:@"CancelarContacto"]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
}

- (IBAction)hecho:(UIStoryboardSegue *)segue{
    
    //Comprueba que el segue se llame GuardarContacto
    if ([[segue identifier] isEqualToString:@"GuardarContacto"]) {
        
        //Creo un puntero que hará referencia al ViewController asociado al segue
        NuevoContacto *nuevoContacto = [segue sourceViewController];
        //Compruebo si me va a devolver un contacto nuevo o uno editado
        if (nuevoContacto.editar) {
            
            }        
        else{
        //Añado el contacto que me devuelve el ViewController a mi lista de contactos
        [self.listaContactos addContacto:nuevoContacto.contacto];
        }
        //Recargo datos de la tabla
        [[self tableView] reloadData];
        
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

@end
