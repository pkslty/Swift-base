//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Foundation

struct NASAjson {
    var date: String
    var explanation: String
    var hdurl: URL
    var title: String
    var url: URL
}

enum NASADataError: Error {
    case noData
    case jsonError
    case noImageData
    case noBigImageData
}

class NasaData {
    var image: UIImage?
    var bigImage: UIImage?
    var dataDecoded = NASAjson(date: "2021-02-27", explanation: "Seen from orbit a day after a dramatic arrival on the martian surface, the Perseverance landing site is identified in this high-resolution view from the Mars Reconnaissance Orbiter. The orbiter's camera image also reveals the location of the Mars 2020 mission descent stage, heat shield, and parachute and back shell that delivered Perseverance to the surface of Mars.  Each annotated inset box spans 200 meters (650 feet) across the floor of Jezero Crater. Perseverance is located at the center of the pattern created by rocket exhaust as the descent stage hovered and lowered the rover to the surface. Following the sky crane maneuver, the descent stage itself flew away to crash at a safe distance from the rover, its final resting place indicated by a dark V-shaped debris pattern. Falling to the surface nearby after their separation in the landing sequence, heat shield, parachute and back shell locations are marked in the high-resolution image from Mars orbit.", hdurl: URL(string: "https://apod.nasa.gov/apod/image/2102/PIA24333_fig1_1035c.jpg")!, title: "Perseverance Landing Site from Mars Reconnaissance Orbiter", url: URL(string: "https://apod.nasa.gov/apod/image/2102/PIA24333_fig1_1035c.jpg")!)
    
    
    func getData() throws {
        
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")!
        
        guard let jsndata = try? Data(contentsOf: url) else {
            throw NASADataError.noData
        }
        print(jsndata)
        
        print(dataDecoded.explanation as Any)
        
        //почему-то jsondecoder не работает в плэйграунде и ошибка его не отлавливается
        //в симуляторе и на устройстве всё работает нормально
        /*do {
            dataDecoded = try JSONDecoder().decode(NASAjson.self, from: jsndata)
        } catch let error {
            throw error
        }*/
        //guard dataDecoded != nil else {
        //    throw NASADataError.jsonError
        //}

        guard let imdata = try? Data(contentsOf: (dataDecoded.url)) else {
            throw NASADataError.noImageData
        }
        
        image = UIImage(data: imdata)
        
        guard let bigimdata = try? Data(contentsOf: dataDecoded.hdurl) else {
            throw NASADataError.noBigImageData
        }
        
        bigImage = UIImage(data: bigimdata)

    }
    
}


class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        
        let imageview = UIImageView()
        //пока размеры прямоугольников наугад
        imageview.frame = CGRect(x: 100, y: 10, width: 200, height: 200)
        view.addSubview(imageview)
        
        let text = UITextView()
        text.frame = CGRect(x: 50, y: 300, width: 300, height: 500)
        view.addSubview(text)
        self.view = view
        
        let data = NasaData()
        do {
            try data.getData()
        } catch NASADataError.jsonError {
            print("Ошибка разбора данных с сайта")
        }
        catch NASADataError.noData {
            print("Не удалось получить данные с сайта")
        }
        catch NASADataError.noImageData {
            print("Не удалось скачать изображение")
        }
        catch NASADataError.noBigImageData {
            print("Не удалось скачать изображение в высоком разрешении")
        }
        catch let error {
            print(error.localizedDescription)
        }
       
        imageview.image = data.image
        text.text = data.dataDecoded.explanation
        
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
