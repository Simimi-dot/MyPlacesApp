//
//  NewPlaceViewController.swift
//  MyPlacesApp
//
//  Created by Егор Астахов on 30.11.2021.
//

import UIKit

class NewPlaceViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var placeImage: UIImageView!
    
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeLocation: UITextField!
    @IBOutlet weak var placeType: UITextField!
    
    var newPlace: Place?
    var imageIsChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Убираем лишнюю разлиновку под таблицей
        tableView.tableFooterView = UIView()
        
        saveButton.isEnabled = false
        // Добавляем таргет. Если в текст филде ничего не написано, то кнопка Save будет отключена
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Если мы нажимаем на первую ячейку, то открывается меню выбора фотографии-картинки, а если мы нажимаем на другие ячейки, то прячется клавиатура
        if indexPath.row == 0 {
            // добавляем иконки
            let cameraIcon = UIImage(named: "camera")
            let photoIcon = UIImage(named: "photo")
            // Делаем алерт контроллер
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            // добавляем иконку
            camera.setValue(cameraIcon, forKey: "image")
            // смещам текст в левую сторону
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            // добавляем иконку
            photo.setValue(photoIcon, forKey: "image")
            // смещаем текст в левую сторону
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            self.present(actionSheet, animated: true)
            
        } else {
            view.endEditing(true)
        }
    }
    
    func saveNewPlace() {
        var image: UIImage?
        
        // Если пользователь подставляет свою картинку, то ствится она. Если пользоваель не используе своюкартинку, то подставляется та, которую мы указали
        if imageIsChanged {
            image = placeImage.image
        } else {
            image = UIImage(named: "imagePlaceholder")
        }
        
        newPlace = Place(name: placeName.text!, location: placeLocation.text, type: placeType.text, image: image, restaurantImage: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
// MARK: - Text field delegate

extension  NewPlaceViewController: UITextFieldDelegate {
    // Скрываем клавиатуру по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if placeName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
}

// MARK: - Work with image
extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // метод работы с изображениями
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            // позволяет пользователю редактировать изображение
            imagePicker.allowsEditing = true
            // определяем тип источника для выбранного изображения
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // присваиваем отредактированное изображение свойству image
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        // Если пользователь использует свою картинку, то значение меняется на true
        imageIsChanged = true
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
}
