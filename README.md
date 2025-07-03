# TravelSurvey 🌍

**Планируй путешествия с умом!** Ответь на вопросы, получи рекомендации и забронируй поездку. ✈️

## 🎯 Возможности

- 📝 Опрос из 7 вопросов о предпочтениях в путешествиях
- 🌴 Рекомендации мест (Сочи, Париж, Мальдивы и др.)
- 🛫 Бронирование поездок с сохранением в JSON
- 📅 Просмотр и удаление запланированных путешествий
- 🖼️ Современный QML-интерфейс с Material стилем

## 🛠 Зависимости

- **Qt 6.9.0** (QML, Core, Gui, Test)
- **CMake 4.1.0+**
- **MinGW 13.1.0** (64-bit)
- Git

## 🔧 Сборка

1. Клонируй репозиторий:
   ```bash
   git clone https://github.com/nvdskhch/TravelSurvey.git
   cd TravelSurvey
Настрой PATH для MinGW:
bash




export PATH=$PATH:C:\Qt\Tools\mingw1310_64\bin
Собери проект:
bash




mkdir build
cd build
cmake .. -G "MinGW Makefiles" -DCMAKE_PREFIX_PATH=C:\Qt\6.9.0\mingw_64
cmake --build .
Разверни зависимости Qt:
bash




C:\Qt\6.9.0\mingw_64\bin\windeployqt.exe bin\appTravelSurvey.exe
Запусти:
bash




bin\appTravelSurvey.exe
Замена путей: Используй свои пути к Qt и MinGW, если они отличаются.

🚀 Использование
Нажми "Начать анкету" и ответь на вопросы.
Получи рекомендации мест (например, Алтай, Токио).
Забронируй поездку: выбери место, даты, путешественников.
Просмотри брони в "Запланированные путешествия".
🤝 Вклад
Форкни репозиторий
Создай ветку: git checkout -b feature
Закоммить изменения: git commit -m "Добавил фичу"
Запушь: git push origin feature
Создай Pull Request
Создано для любителей путешествий! 🌴
```
