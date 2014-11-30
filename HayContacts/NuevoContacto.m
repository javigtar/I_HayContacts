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
    
    //Inicia Los valores del UIPickerView
    [self initGrupoPicker];
    
    //Imagen por defecto de los contactos
    self.imagenContacto = [UIImage imageNamed:@"contacto.png"];
    
    //Poner los bordes redondeados a la imagen de contacto
    self.nuevaImagen.layer.cornerRadius = 40;
    self.nuevaImagen.clipsToBounds = YES;
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

//Se ejecutará cuando apretemos sobre el botón imagenContacto. Mostrará una alerta y nos permitirá seleccionar
//la opcion de elegir una imagen de la galería o hacerla con la cámara
- (IBAction)nuevaImagen:(UIButton *)sender{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Añadir Foto" message:nil delegate:self cancelButtonTitle:@"Cancelar"
                                          otherButtonTitles:@"Desde Cámara", @"Desde Galería",nil];
    [alert show];
    
}

//Se ejecutará cuando hayamos elegido una opción para añadir una foto al contacto según lo que hayamos decidido
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
    //Pone la imagen como fondo del botón
    [self.nuevaImagen setBackgroundImage:self.imagenContacto forState:UIControlStateNormal];
}

//Número de columnas que se mostrarán en el Picker View
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//Devuelve el número de filas del PickerView
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.datosPicker.count;
}

//Inicia Los valores del UIPickerView
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

//Comprueba si los campos obligatorios estan rellenos, si lo estan devuelve YES y se ejecutara prepareForSegue, si devuelve NO, mostrara un alert
//informando que faltan campos por rellenar y no se ejecutaá el segue
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{    
    
   
    if ([[sender title]isEqualToString:@"Grabar"]) {
    
        //Compruebo que el segue se llame GuardarContacto y que los campos obligatorios esten rellenos
        if ([identifier isEqualToString:@"GuardarContacto"] && [self comprobarCamposObligatorios]) {
        
            [self crearContacto];
        
            return YES;
        }
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Faltan campos obligatorios por rellenar"
                                                       delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alert show];
    
        return NO;
    }
    
    return  YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

//Comprueba que los campos: nombre, apellidos y telefono contengan datos
-(BOOL)comprobarCamposObligatorios{
    
    if ([self.nombre.text length] && [self.apellidos.text length] && [self.telefono.text length]){
        return YES;
    }
    
    return NO;
    
}

//Crea un contacto y lo añade a la lista de contactos
-(void)crearContacto{
    
        NSNumber *telefono = [[NSNumber alloc] initWithInteger:[self.telefono.text integerValue]];
        //Creo el objeto contacto con los datos de los 3 campos obligatorios
        self.contacto = [[Contacto alloc] initWithNombre:self.nombre.text apellidos:self.apellidos.text telefono:telefono];
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
        
        [self.listaContactos addContacto:self.contacto];
    
}

@end