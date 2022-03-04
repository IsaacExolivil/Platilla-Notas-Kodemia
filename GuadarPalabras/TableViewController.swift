//
//  TableViewController.swift
//  GuadarPalabras
//
//  Created by Isaac on 04/03/22.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
   // var palabrasTabla: [String] = ["Manzana", "Pera", "Uva"]
    
    var managedObjects:[NSManagedObject] = []
    
    //Cada un de los objetos de este arreglo es del tipo NSManagerObject y representa un objeto guardado en Core Data, estso objetos se utilizan para crear, guardar editar y eliminar datos persistentes en core Data.
    
    
    //Los objetos de NSManagedObject (como los de este arreglo) pueden tomar diferentes formas, es decir que pueden tomar la forma de cualquier entidad de tu "data model" (representado en el archivo: "GuardarPalabras") y se apropriara de cualquier atributo o relación que tu definas en dicho modo "data model"

    override func viewDidLoad() {
        super.viewDidLoad()
        //1
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        //2 fetch = ir a buscar
        let fetchtRequest = NSFetchRequest<NSManagedObject>(entityName: "Lista")
        // 3
        do {
            managedObjects = try managedContext.fetch(fetchtRequest)
        } catch let error as NSError {
            print("No se puede recuperar los datos guardados. el Errror fue \(error), \(error.userInfo)")
        }
        

        
    }

    // MARK: - Table view data source
   //Cuantas secciones tiene la tabla
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

         //cuantas filas tendra nuestro arreglo
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return managedObjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        
        let managedObject = managedObjects[indexPath.row]
        
        cell.textLabel?.text = managedObject.value(forKey: "palabra") as?
        String
       // cell.textLabel?.text = palabrasTabla[indexPath.row]

        return cell
    }
    
 
    @IBAction func agregarPalabra(_ sender: Any) {
        
            let alerta = UIAlertController(title: "Nueva Palabra", message: "Por favor Agrega Nueva Palabra", preferredStyle: .alert)
            
            let guardar = UIAlertAction(title: "Agregar", style: .default, handler: {
                (action:UIAlertAction) -> Void in
                
                let texField = alerta.textFields!.first
                self.guardarPalabra(palabra: texField!.text!)
              //  self.palabrasTabla.append(texField!.text!)
                self.tableView.reloadData()
                
            })
            
            let cancelar = UIAlertAction(title: "Cancelar", style: .default)
            
            {(action: UIAlertAction) -> Void in }
            
            alerta.addTextField {(textField:UITextField) -> Void in}
            
            alerta.addAction(guardar)
            alerta.addAction(cancelar)
            
            present(alerta, animated: true, completion: nil)
      
        }
    
    func guardarPalabra(palabra: String) {
        // 1)Para guardar o recuperar datos en Core Data necesitamos un objeto del tipo "managedObjectContext", podemos verlo como una libreta de apuntes o borradores donde trabajas con objetos del tipo "NS managed Object".
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        //Puedes verlo como que primero pones un nuevo objeto del tipo "managed Object" dentro de tu "libreta de apuntes o borradores" (managedObjectContext) y una vez que tengas preparado tu objeto "NS managed Object" a como tu lo quieres ya le puedes decir a tu "libreta de apuntes" (managedObjectContext) que guarde los cambios en el "disco duro" de tu app.
        
    
        
        
        // 2)Entonces creamos un objeto del tipo "NSManagedObject" por medio de la definicion de clase "Entity" y con la ayuda de tu objeto de tipo "managedObjectContext"
        let entity = NSEntityDescription.entity(forEntityName: "Lista", in: managedContext)!
      
        let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        
        
        // 3) Le añadimos valores a las propiedades de dicho objeto (en este caso solo tenemos la propiedad de "palabra")
        managedObject.setValue(palabra, forKeyPath: "palabra")
    
        
        
        //4) Y con la ayuda de nuestro objeto del tipo "managedObjectContext" (libreta de apuntes o borradores), guardamos los cambios
        
        do {
            try managedContext.save()
            managedObjects.append(managedObject)
        } catch let error as NSError {
            print("No se pudo guardar, error: \(error), \(error.userInfo)")
        }
        
    }
    }
    

