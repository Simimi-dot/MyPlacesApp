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
            // Делаем алерт контроллер
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            self.present(actionSheet, animated: true)
            
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

// MARK: - Work with image
extension NewPlaceViewController {
    // метод работы с изображениями
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            // позволяет пользователю редактировать изображение
            imagePicker.allowsEditing = true
            // определяем тип источника для выбранного изображения
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
        
    }
}
