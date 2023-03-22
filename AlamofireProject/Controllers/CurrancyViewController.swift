
import UIKit
import Alamofire
import SnapKit
import SwiftyJSON

class CurrancyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    var array = [String]()
    
//    var arrayCurrancy: [Currency] = []
    
    let url = "https://api.apilayer.com/fixer/latest?apikey:8MZIytWC5qJi6z6C9ye1h4VIaYCCSMvw&base=EUR"
    let key = "8MZIytWC5qJi6z6C9ye1h4VIaYCCSMvw"
    let base = "EUR"
    let symbols = "RUB, USD"
    
    let header = "apikey"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.cornerRadius = 20
        tableView.clipsToBounds = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self

        setupUI()
      
        let param = ["apikey" : key,
                     "base" : base,
                     "symbols" : symbols]
        
        getPrice(url: url, key: key, header: header, parameters: param)
    }
    
    private func getPrice(url: String, key: String, header: String, parameters: [String : String]) {
        let header = HTTPHeaders(dictionaryLiteral: (header, key))
        AF.request(url, method: .get, parameters: parameters, headers: header).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.title = "\(json["base"])"
                self.updatePrices(json: json)
            case .failure(let error):
                print(error)
            }
            self.tableView.reloadData()
            print(response)

        }
        
        
        
        //8MZIytWC5qJi6z6C9ye1h4VIaYCCSMvw
    }
    
    private func setupUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
                  make.centerX.equalTo(self.view.snp.centerX)
                  make.centerY.equalTo(self.view.snp.centerY)
                  make.height.equalTo(600)
                  make.width.equalTo(370)
              }
    }

    func updatePrices(json: JSON) {
        for (name, price) in json["rates"] {
          let currancy = "\(name) \(price)"
            array.append(currancy)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
}

