//
//  ViewController.swift
//  MovieSearch
//
//  Created by Duver on 10/12/22.
//

import UIKit
import Alamofire
import Kingfisher


class ViewController: UIViewController {
  
  @IBOutlet weak var nombrePelicula: UITextField!
  
  @IBOutlet weak var titulo: UILabel!
  
  @IBOutlet weak var fechaLanzamiento: UILabel!
  
  @IBOutlet weak var premios: UILabel!
  
  @IBOutlet weak var actores: UILabel!
  
  @IBOutlet weak var genero: UILabel!
  
  @IBOutlet weak var poster: UIImageView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
  }
  
  func buscar(){
//    validar nombre no vacio
    if !nombrePelicula.text!.isEmpty {
      AF.request("https://omdbapi.com/?apikey=99cc4d2d&t=\(nombrePelicula.text ?? "")").responseDecodable(of: Movie.self) { (respuesta) in
//        pintar UI
        self.titulo.text = respuesta.value?.title ?? ""
        self.fechaLanzamiento.text = respuesta.value?.released
        self.actores.text = respuesta.value?.actors
        self.premios.text = respuesta.value?.awards
        self.genero.text = respuesta.value?.genre
        
//        poster de la pelicula
        let urlNoImage = "http://www.tea-tron.com/antorodriguez/blog/wp-content/uploads/2016/04/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png"
        guard let url = URL(string: respuesta.value?.poster ?? urlNoImage)else{return}
        self.poster.kf.setImage(with: url)
        
//        limpiar el textfield
        self.nombrePelicula.text = ""
        
      }
    }else{
      let alerta = UIAlertController(title: "Error", message: "Es necesario escribir el nombre", preferredStyle: .alert)
      let accionAceptar = UIAlertAction(title: "Aceptar", style: .default){(_) in
        print("Contacto Agregado")
      }
      alerta.addAction(accionAceptar)
      present(alerta,animated: true)
    }
  }
  
  @IBAction func buscarBtn(_ sender: Any) {
    buscar()
  }
  
}

