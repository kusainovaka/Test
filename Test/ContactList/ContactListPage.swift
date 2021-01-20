//
//  ContactListPage.swift
//  ContactList
//
//  Created by Kamila Kussainova on 31.12.2020.
//

import UIKit
import Contacts

class ContactListPage: UIViewController {
    let contactStore = CNContactStore()
    var contacts = [CNContact]()
    var some = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        view.addSubview(button)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(action), for: .touchUpInside)
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
//        test()
    }

    @objc func action() {
        if let data = try? JSONEncoder().encode(some) {
            UserDefaults.standard.set(data, forKey: "mama1")
        }

        print(contacts.count, "Helllo 👹👹👹👹👹")
        print(some.count)
        let store = CNContactStore()
        
        if
            let data = UserDefaults.standard.value(forKey: "mama1") as? Data,
            let configuration = try? JSONDecoder().decode([User].self, from: data) {
            print(configuration.count)
//            configuration.forEach { model in
//                let contact = CNMutableContact()
//                contact.givenName = model.givenName
//
//                for (kind, numbers) in model.phoneNumbers.enumerated() {
//                    contact.phoneNumbers.append(CNLabeledValue(label: numbers.key,
//                                                               value: CNPhoneNumber(stringValue: numbers.key)))
//                }
//                contact.familyName = model.familyName
//                contact.middleName = model.middleName
//                let saveRequest = CNSaveRequest()
//                saveRequest.add(contact, toContainerWithIdentifier: nil)
//                try? store.execute(saveRequest)
//            }
        }
        
//        if let some = UserDefaults.standard.object(forKey: "testKey") as? [User] {
//            print(some.count, "👹👹👹👹👹")
//        }
//        if let data = UserDefaults.standard.value(forKey:"yourKey") as? Data {
//            guard let songs2 = try? PropertyListDecoder().decode(Array<User>.self, from: data) else { return }
//            print(songs2, "45445")
//        }
 
    }
    
    func test() {
        let keys = [
                CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                        CNContactPhoneNumbersKey,
                        CNContactEmailAddressesKey
                ] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request){
                    (contact, stop) in
                self.contacts.append(contact)
                var persons = [String: String]()
                for phoneNumber in contact.phoneNumbers {
                    if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
                        let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
                        persons[localizedLabel] = number.stringValue
                    }
                }
                
                let model = User(givenName: contact.givenName, phoneNumbers: persons,
                                 familyName: contact.familyName, middleName: contact.middleName)
                self.some.append(model)
            }
//            print(contacts)
        } catch {
            print("unable to fetch contacts")
        }
    }
}



struct User: Codable {
    let givenName: String
    let phoneNumbers: [String: String]
    let familyName: String
    let middleName: String
//    let emailAddresses: String
//    let departmentName: String
//    let organizationName: String
//    let jobTitle: String
//    let imageData: Data?
}
