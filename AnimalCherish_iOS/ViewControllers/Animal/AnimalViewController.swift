
import UIKit
import Alamofire
import SwiftyJSON

struct animalStruct {
    let id : String!
    let name : String!
    let type : String!
    let genus : String!
}

class AnimalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/animal/getall"
    var loadingIndicatorAlert: UIAlertController? = nil
    let menuSlide = MenuSlide()
    
    var animals = [animalStruct]()
    lazy var filteredData = self.animals
    var selectedType: String? = nil
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        getAnimalList()
        
        self.searchBar.delegate = self
        
        // UISegmentedControl - set default segment index
        segmentControl.selectedSegmentIndex = 0
        
        selectedType = "dog"
        
    }
    
    // MARK: Data Preparation and GET request
    func getAnimalList() {
        
        // show loading indicator
        //loadingIndicator()
        
        AF.request(apiUrl, method: .get).responseJSON { (myresponse) in
            
            // check result is success or failure
            switch myresponse.result {
            case .success:
                
                // GET data
                let myresult = try? JSON(data: myresponse.data!)
                let resultArray = myresult!
                
                //
                for item in resultArray.arrayValue {
                    
                    let id = item["id"].stringValue
                    let name = item["name"].stringValue
                    let type = item["turAd"].stringValue
                    let genus = item["cinsAd"].stringValue
                    
                    self.animals.insert(animalStruct(id: id, name: name, type: type, genus: genus), at: 0)

                }
                
                // prepare filtered data
                self.filteredData = self.animals
                
                // reload table data
                self.tableView.reloadData()
                
                // close loading indicator
                //self.loadingIndicatorAlert!.dismiss(animated: false, completion: nil)
                
                break
            case .failure:
                
                // close loading indicator
                //self.loadingIndicatorAlert!.dismiss(animated: false, completion: nil)
                
                self.showAlert(for: "Bir hata oluştu. Hayvan Listesi Getiriemedi!")
                print(myresponse.error!)
                break
            }
            
        }
    }
    
    // MARK: UISegmentedControl
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        
        // change title, image and pickerView hidden
        switch segmentControl.selectedSegmentIndex {
        case 0:
            
            // Köpek
            selectedType = "dog"
            
        case 1:
            
            // Kuş
            selectedType = "bird"
            
        case 2:
            
            // Yılan
            selectedType = "snake"
            
        case 3:
            
            // Böcek
            selectedType = "insect"
            
            
        case 4:
            
            // Balık
            selectedType = "fish"
            
            
        default:
            break
        }
        
        self.tableView.reloadData()
        
    }
    
    // MARK: Show Menu
    @IBAction func menuButtonPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController1") as! MenuViewController
        
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
        
    }
    
    // MARK: Alert
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "animalcell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "animalcell")
        }
        
        cell?.textLabel?.text = filteredData[indexPath.row].name
        cell?.detailTextLabel?.text = (filteredData[indexPath.row].type ) + ", " + (filteredData[indexPath.row].genus )
        
        cell?.imageView?.frame = CGRect(x: 0, y: 0, width: 50, height: 100)
        
        if selectedType == "dog" {
            cell?.imageView?.image = UIImage(named: "dog3")
        } else if selectedType == "bird" {
            cell?.imageView?.image = UIImage(named: "bird3")
        } else if selectedType == "snake" {
            cell?.imageView?.image = UIImage(named: "snake3")
        } else if selectedType == "insect" {
            cell?.imageView?.image = UIImage(named: "insect3")
        } else if selectedType == "fish" {
            cell?.imageView?.image = UIImage(named: "fish3")
        } else  {}
        
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               
        if let viewController = storyboard?.instantiateViewController(identifier: "goToEditAnimalScreen") as? DeatilAnimalViewController {
            viewController.selectedId = Int (filteredData[indexPath.row].id)
            navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    // MARK: UISearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData = self.animals.filter({ $0.name
            .hasPrefix(searchText) })
        self.tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        self.filteredData = self.animals
        self.tableView.reloadData()
    }
    
}
