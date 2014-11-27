//
//  NuevoContacto.m
//  HayContacts
//
//  Created by alumno on 25/11/14.
//  Copyright (c) 2014 javi. All rights reserved.
//

#import "NuevoContacto.h"
#import "Contacto.h"
#import "ListaContactos.h"

@interface NuevoContacto ()

@property (weak, nonatomic) IBOutlet UIButton *nuevaImagen;
@property (nonatomic) IBOutlet UIImage *imagenContacto;
@property (weak, nonatomic) IBOutlet UIPickerView *grupoPicker;
@property (nonatomic) NSString *grupoSeleccionado;

@end

@implementation NuevoContacto

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initGrupoPicker];
    
    self.editar = false;
    
    if (self.contacto) {
        self.imagenContacto = self.contacto.imagenContacto;
        self.nombre.text = self.contacto.nombre;
        self.apellidos.text = self.contacto.apellidos;
        self.telefono.text = [self.contacto.telefono stringValue];
        self.direccion.text = self.contacto.direccion;
        self.mail.text = self.contacto.mail;
        self.twitter.text = self.contacto.twitter;
        self.facebook.text = self.contacto.facebook;
        [self.whatsapp setOn:self.contacto.whatsapp];
        [self.grupoPicker selectRow:[self filaGrupo:self.contacto.grupo] inComponent:0 animated:NO];
        
        self.editar = true;
    }
    
    //Imagen por defecto de los contactos
    self.imagenContacto = [UIImage imageNamed:@"contacto.png"];
    
    //Poner los bordes redondeados a la imagen de contacto
    self.nuevaImagen.layer.cornerRadius = 40;
    self.nuevaImagen.clipsToBounds = YES;
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//Se ejecutará cuando apretemos sobre el botón Imagen Contacto y nos permitirá seleccionar una imagen de la galería
- (IBAction)nuevaImagen:(UIButton *)sender{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Añadir Foto" message:nil delegate:self cancelButtonTitle:@"Cancelar"
                                          otherButtonTitles:@"Desde Cámara", @"Desde Galería",nil];
    [alert show];
    
}

//Se ejecutará cuando hayamos elegido una opción para añadir una foto al contacto
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    //Botón de seleccionar desde cámara (NO FUNCIONA, SUPONGO QUE SERÁ PORQUE NO LLEVA CÁMARA EL EMULADOR)
    if (buttonIndex == 1) {
        //Inicia el controlador
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        //Define el delegado
        picker.delegate = self;
        //Establece la cámara como origen de la imagen
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //Agrega la vista del controlador a la pantalla
        [self presentViewController:picker animated:YES completion:nil];
    }
    //Botón de seleccionar desde galería
    else if (buttonIndex == 2) {
        //Inicia el controlador
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        //Define el Delegate
        picker.delegate = self;
        //Permite la edición de la foto
        picker.allowsEditing = YES;
        //Establece el origen de la imagen
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //Agrega la vista del controlador a la pantalla
        [self presentViewController:picker animated:YES completion:nil];
    }
}

//Se ejecutará cuando hayamos seleccionado la foto de la galería para ponerla en el contacto
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //Quita la vista del controlador
    [self dismissViewControllerAnimated:YES completion:nil];
    //Establece la imagen tomada en un objeto UIImageView
    self.imagenContacto = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //Poner la imagen como fondo del botón
    [self.nuevaImagen setBackgroundImage:self.imagenContacto forState:UIControlStateNormal];
}

//Número de columnas que se mostrarán en el Picker View
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.datosPicker.count;
}

- (void)initGrupoPicker{
    //Creo una array con los datos que contendrá el Picker View
    self.datosPicker = @[@"Favoritos", @"Familia", @"Amigos", @"Trabajo", @"Clase", @"Otros"];
    //Decimos al Picker View que los datos los cogerá de este View Controller y que tambien será su delegado
    self.grupoPicker.dataSource = self;
    self.grupoPicker.delegate = self;
    
}

// Datos que mostrará el Picker View
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.datosPicker[row];
}

// Devuelve la opcion selecionada del PickerView
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    self.grupoSeleccionado = self.datosPicker[row];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //Compruebo que el segue se llame GuardarContacto y guardo el contacto nuevo en la lista de contactos
    if ([[segue identifier] isEqualToString:@"GuardarContacto"]) {
        
        if (!self.editar) {
            [self crearContacto];
        }
        else{
            
        }
    }
}

-(void)crearContacto{
    
    //Compruebo que los campos: nombre, apellidos y telefono contengan datos
    if ([self.nombre.text length] && [self.apellidos.text length] && [self.telefono.text length]) {
        NSNumber *telefono = [[NSNumber alloc] initWithInteger:[self.telefono.text integerValue]];
        //Creo el objeto contacto con los datos de los 3 campos obligatorios
        self.contacto = [[Contacto alloc] initWithParams:self.nombre.text apellidos:self.apellidos.text telefono:telefono];
        //Añado las propiedades restantes
        self.contacto.imagenContacto = self.imagenContacto;
        self.contacto.direccion = self.direccion.text;
        self.contacto.mail = self.mail.text;
        //Comprueba que se hayan metido datos en el campo Twitter para añadirle @ delante del nombre de usuario
        if ([self.twitter.text length]) {
            self.contacto.twitter = [[NSString alloc] initWithFormat:@"@%@", self.twitter.text ];
        }
        //Comprueba que se hayan metido datos en el campo Facebook para añadirle la direccion web de la pagina
        if ([self.facebook.text length]) {
            self.contacto.facebook = [[NSString alloc] initWithFormat:@"https://www.facebook.com/%@", self.facebook.text];
        }
        self.contacto.grupo = self.grupoSeleccionado;
        self.contacto.whatsapp = [self.whatsapp isOn];
    }
    
    [self.listaContactos addContacto:self.contacto];
}

//Devuelve el indice del Array de grupos donde se encuentre el grupo que le pasamos por parámetro
-(NSInteger)filaGrupo:(NSString*)grupo{
    
    for (int i=0 ; i < self.datosPicker.count ; i++) {
        NSString *nombreGrupo = [[NSString alloc] initWithString:self.datosPicker[i]];
        if ([grupo isEqualToString:nombreGrupo]) {
            return i;
        }
    }
    return 0;
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