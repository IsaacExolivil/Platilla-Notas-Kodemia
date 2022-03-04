//
//  TableViewController.swift
//  GuadarPalabras
//
//  Created by Isaac on 04/03/22.
//

import UIKit

class TableViewController: UITableViewController {
    
    var palabrasTabla: [String] = ["Manzana", "Pera", "Uva"]

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        return palabrasTabla.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = palabrasTabla[indexPath.row]

        return cell
    }
    
 
    @IBAction func agregarPalabra(_ sender: Any) {
        
            let alerta = UIAlertController(title: "Nueva Palabra", message: "Por favor Agrega Nueva Palabra", preferredStyle: .alert)
            
            let guardar = UIAlertAction(title: "Agregar", style: .default, handler: {
                (action:UIAlertAction) -> Void in
                
                let texField = alerta.textFields!.first
                self.palabrasTabla.append(texField!.text!)
                self.tableView.reloadData()
                
            })
            
            let cancelar = UIAlertAction(title: "Cancelar", style: .default)
            
            {(action: UIAlertAction) -> Void in }
            
            alerta.addTextField {(textField:UITextField) -> Void in}
            
            alerta.addAction(guardar)
            alerta.addAction(cancelar)
            
            present(alerta, animated: true, completion: nil)
      
        }
    }
    

