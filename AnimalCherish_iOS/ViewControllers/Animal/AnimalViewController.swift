
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
    
    var animals = [animalStruct]()
    lazy var filteredData = self.animals
    var selectedType: String? = nil
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        
        // UISegmentedControl - set default segment index
        segmentControl.selectedSegmentIndex = 0
        selectedType = "all"
        
        getAnimalList(type: selectedType!)
        
    }
    
    // MARK: Data Preparation and GET request
    func getAnimalList(type: String) {
        
        // show loading indicator
        self.showLoadingIndicator(onView: self.view)
        
        AF.request(apiUrl, method: .get).responseJSON { (myresponse) in
            
            // check result is success or failure
            switch myresponse.result {
            case .success:
                
                self.animals.removeAll()
                
                // GET data
                let myresult = try? JSON(data: myresponse.data!)
                let resultArray = myresult!
                
                //
                for item in resultArray.arrayValue {
                    
                    let id = item["id"].stringValue
                    let name = item["name"].stringValue
                    let type = item["turAd"].stringValue
                    let genus = item["cinsAd"].stringValue
                    
                    if self.selectedType == "all" {
                        self.animals.insert(animalStruct(id: id, name: name, type: type, genus: genus), at: 0)
                    } else if self.selectedType == "dog" {
                        if type == "Köpek"  {
                            self.animals.insert(animalStruct(id: id, name: name, type: type, genus: genus), at: 0)
                        }
                    } else if self.selectedType == "cat" {
                        if type == "Kedi"  {
                            self.animals.insert(animalStruct(id: id, name: name, type: type, genus: genus), at: 0)
                        }
                    } else if self.selectedType == "bird" {
                        if type == "Kuş"  {
                            self.animals.insert(animalStruct(id: id, name: name, type: type, genus: genus), at: 0)
                        }
                    } else  {
                        if type != "Köpek" && type != "Kedi" && type != "Kuş" {
                            self.animals.insert(animalStruct(id: id, name: name, type: type, genus: genus), at: 0)
                        }
                    }
                    
                    
                }
                
                // prepare filtered data
                self.filteredData = self.animals
                
                // reload table data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                // remove loading indicator
                self.removeLoadingIndicator()
                
                break
            case .failure:
                
                // remove loading indicator
                self.removeLoadingIndicator()
                
                // show error
                Alert.showAlert(message: "Bir hata oluştu. Veteriner Hekim Listesi Getiriemedi!", vc: self)
                break
                
            }
            
        }
    }
    
    // MARK: UISegmentedControl
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        
        // change title, image and pickerView hidden
        switch segmentControl.selectedSegmentIndex {
        case 0:
            
            // Tamamı
            selectedType = "all"
            
        case 1:
            
            // Köpek
            selectedType = "dog"
            
        case 2:
            
            // Kedi
            selectedType = "cat"
            
        case 3:
            
            // Kuş
            selectedType = "bird"
            
            
        case 4:
            
            // Diğer
            selectedType = "other"
            
            
        default:
            break
        }
        
        getAnimalList(type: selectedType!)
        self.tableView.reloadData()
        
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
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = storyboard?.instantiateViewController(identifier: "goToEditAnimalScreen") as? DeatilAnimalViewController {
            viewController.selectedId = self.filteredData[indexPath.row].id
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
