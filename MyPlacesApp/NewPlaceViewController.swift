//
//  NewPlaceViewController.swift
//  MyPlacesApp
//
//  Created by Егор Астахов on 30.11.2021.
//

import UIKit

class NewPlaceViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Убираем лишнюю разлиновку под таблицей
        tableView.tableFooterView = UIView()
        
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Если мы нажимаем на первую ячейку, то открывается меню выбора фотографии-картинки, а если мы нажимаем на другие ячейки, то прячется клавиатура
        if indexPath.row == 0 {
            
        } else {
            view.endEditing(true)
        }
    }

}
// MARK: - Text field delegate

extension  NewPlaceViewController: UITextFieldDelegate {
    // Скрываем клавиатуру по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
