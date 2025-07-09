[VC_Plan.pdf](https://github.com/user-attachments/files/21132924/VC_Plan.pdf)
![Screen1](https://github.com/user-attachments/assets/d1d65906-9e36-48e8-b99f-8f9dd5dd0b5d)
![Screen2](https://github.com/user-attachments/assets/e42283d3-4e2b-4e0c-b61f-abed9f2e8b8a)


1. Используемая архитектура
   - Основной подход: MVC (Model-View-Controller) с элементами императивного программирования.

Model:
   - Post, APIDataImage – структуры для декодирования JSON.

PostsApiWork, ImageApiWork – классы для работы с API (сетевые запросы).

View:
   - CastomCell – кастомная ячейка таблицы.

Controller:
   - ViewController – управляет логикой отображения данных в UITableView.



2. Ключевые особенности
Сетевые запросы:

   - Используется URLSession для загрузки данных.

   - Данные обрабатываются через JSONDecoder.

UI:

   - Верстка кодом (Auto Layout в CastomCell).

   - Обновление интерфейса через DispatchQueue.main.async.

Состояние приложения:

   - Поддержка Core Data (хотя в коде не используется активно).


СТЕК:
Swift, UIKit, UITableView, UIRefreshControl, URLSession, JSONDecoder, Codable, Auto Layout, Core Data (не активно), DispatchQueue (GCD), REST API (jsonplaceholder.typicode.com, dog.ceo), MVC


Инструкция по сборке проекта

1. Клонируйте репозиторий:
   
   git clone https://github.com/DaniarKamaev/Nedo-VK.git
   cd Nedo-VK

3. Откройте проект в Xcode:  
   - Запустите Xcode.  
   - Выберите File → Open и укажите папку с проектом.  

4. Выберите симулятор или устройство:* 
   - В верхней панели Xcode выберите подходящий симулятор. 

5. Запустите сборку:
   - Нажмите Run или.
     
6. роверьте работу приложения: 
   - После запуска должно появиться окно симулятора с таблицей постов и изображениями.  

 Возможные проблемы:  
- Ошибки API: Если данные не загружаются, проверьте URL в PostsApiWork и ImageApiWork.  
- Отсутствие изображений: Убедитесь, что есть fallback (например, notFound.png).

ГОТОВО
