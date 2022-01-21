//U-N00B-or-Bot

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var romashka: UIActivityIndicatorView!
    @IBOutlet weak var tempInfoLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    let imageUrl = "https://mytravelry.com/ru/wp-content/uploads/sites/2/2019/01/Eifel-COVER.jpg"
    let jsonUrl = "https://api.openweathermap.org/data/2.5/onecall?lat=48.8534100&lon=2.3488000&exclude=minutely,alerts,hourly&units=metric&lang=ru&appid=4ef2e9edd95153ca4989b50f0fafc65f"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        romashka.startAnimating()
        romashka.hidesWhenStopped = true
        getImage()
        parsingJSON()
    }

    
    private func getImage(){
        guard let url = URL(string: imageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else { return }
                self.image.image = image
            }
            
        }.resume()
    }
    
    //JSON START-----
    private func parsingJSON() {
        guard let url = URL(string: jsonUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            DispatchQueue.main.async {
                do{
                    let temper = try JSONDecoder().decode(Temp.self, from: data)
                    self.tempInfoLabel.text = "Current temp in Paris:\n~\(String(round(10*(temper.current.temp))/10)) °"
                    self.romashka.stopAnimating()
                }catch {
                    print(error.localizedDescription)
                }
                
            }
           
           
        }.resume()
    }
    //JSON STOP-----

}


