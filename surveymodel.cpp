#include "surveymodel.h"

SurveyModel::SurveyModel(QObject *parent) : QObject(parent) {
    // Определяем категории (каждая категория соответствует возможному ответу)
    categories = {
        "теплый", "умеренный", "холодный", // Климат
        "активный", "пассивный", // Активность
        "эконом", "средний", "премиум", // Бюджет
        "море", "лес", "пустыня", "город", "степь", "горы", // Природные условия
        "с контактом с животными", "без контакта с животными", // Контакт с фауной
        "с культурными достопримечательностями", "без культурных достопримечательностей", // Культура
        "в пределах страны (РФ)", "соседние страны (страны бывшего СССР)", "остальной мир" // Дальность
    };

    // Определяем 10 мест с категориями и описаниями
    places.append({{"name", "Сочи"}, {"categories", QStringList{"теплый", "море", "средний", "с культурными достопримечательностями", "в пределах страны (РФ)"}}, {"description", "Сочи — курортный город на Черноморском побережье России, известный своими пляжами, горами и олимпийскими объектами."}});
    places.append({{"name", "Алтай"}, {"categories", QStringList{"холодный", "активный", "горы", "с контактом с животными", "в пределах страны (РФ)"}}, {"description", "Алтай — регион с потрясающими горными пейзажами, чистыми реками и возможностями для активного отдыха, такого как походы и рафтинг."}});
    places.append({{"name", "Санкт-Петербург"}, {"categories", QStringList{"умеренный", "пассивный", "средний", "город", "с культурными достопримечательностями", "в пределах страны (РФ)"}}, {"description", "Санкт-Петербург — культурная столица России с музеями, дворцами и красивыми набережными Невы."}});
    places.append({{"name", "Дубай"}, {"categories", QStringList{"теплый", "пустыня", "премиум", "город", "с культурными достопримечательностями", "остальной мир"}}, {"description", "Дубай — современный мегаполис в пустыне с небоскрёбами, роскошными отелями и крупнейшим в мире торговым центром."}});
    places.append({{"name", "Карелия"}, {"categories", QStringList{"холодный", "активный", "лес", "с контактом с животными", "эконом", "в пределах страны (РФ)"}}, {"description", "Карелия — край лесов, озёр и водопадов, идеальное место для любителей природы и спокойного отдыха."}});
    places.append({{"name", "Мальдивы"}, {"categories", QStringList{"теплый", "пассивный", "море", "премиум", "без культурных достопримечательностей", "остальной мир"}}, {"description", "Мальдивы — райские острова с белоснежными пляжами, бирюзовой водой и идеальными условиями для релакса."}});
    places.append({{"name", "Киев"}, {"categories", QStringList{"умеренный", "средний", "город", "с культурными достопримечательностями", "соседние страны (страны бывшего СССР)"}}, {"description", "Киев — исторический город с богатым культурным наследием, красивыми соборами и живописными видами на Днепр."}});
    places.append({{"name", "Сахара"}, {"categories", QStringList{"теплый", "активный", "пустыня", "с контактом с животными", "остальной мир"}}, {"description", "Сахара — крупнейшая пустыня в мире, где можно увидеть бескрайние песчаные дюны и встретить уникальную фауну."}});
    places.append({{"name", "Париж"}, {"categories", QStringList{"умеренный", "пассивный", "премиум", "город", "с культурными достопримечательностями", "остальной мир"}}, {"description", "Париж — столица Франции, известная Эйфелевой башней, Лувром и богатой культурой."}});
    places.append({{"name", "Токио"}, {"categories", QStringList{"умеренный", "пассивный", "премиум", "город", "с культурными достопримечательностями", "остальной мир"}}, {"description", "Токио — динамичная столица Японии с уникальным сочетанием традиций и современных технологий."}});

    // Определяем стоимости поездок (90 маршрутов)
    tripCosts = {
        {"Сочи-Алтай", 10000}, {"Сочи-Санкт-Петербург", 10000}, {"Сочи-Дубай", 25000}, {"Сочи-Карелия", 10000}, {"Сочи-Мальдивы", 25000}, {"Сочи-Киев", 15000}, {"Сочи-Сахара", 25000}, {"Сочи-Париж", 25000}, {"Сочи-Токио", 25000},
        {"Алтай-Сочи", 10000}, {"Алтай-Санкт-Петербург", 10000}, {"Алтай-Дубай", 25000}, {"Алтай-Карелия", 10000}, {"Алтай-Мальдивы", 25000}, {"Алтай-Киев", 15000}, {"Алтай-Сахара", 25000}, {"Алтай-Париж", 25000}, {"Алтай-Токио", 25000},
        {"Санкт-Петербург-Сочи", 10000}, {"Санкт-Петербург-Алтай", 10000}, {"Санкт-Петербург-Дубай", 25000}, {"Санкт-Петербург-Карелия", 10000}, {"Санкт-Петербург-Мальдивы", 25000}, {"Санкт-Петербург-Киев", 15000}, {"Санкт-Петербург-Сахара", 25000}, {"Санкт-Петербург-Париж", 18000}, {"Санкт-Петербург-Токио", 25000},
        {"Дубай-Сочи", 25000}, {"Дубай-Алтай", 25000}, {"Дубай-Санкт-Петербург", 25000}, {"Дубай-Карелия", 25000}, {"Дубай-Мальдивы", 25000}, {"Дубай-Киев", 25000}, {"Дубай-Сахара", 25000}, {"Дубай-Париж", 25000}, {"Дубай-Токио", 25000},
        {"Карелия-Сочи", 10000}, {"Карелия-Алтай", 10000}, {"Карелия-Санкт-Петербург", 10000}, {"Карелия-Дубай", 25000}, {"Карелия-Мальдивы", 25000}, {"Карелия-Киев", 15000}, {"Карелия-Сахара", 25000}, {"Карелия-Париж", 25000}, {"Карелия-Токио", 25000},
        {"Мальдивы-Сочи", 25000}, {"Мальдивы-Алтай", 25000}, {"Мальдивы-Санкт-Петербург", 25000}, {"Мальдивы-Дубай", 25000}, {"Мальдивы-Карелия", 25000}, {"Мальдивы-Киев", 25000}, {"Мальдивы-Сахара", 25000}, {"Мальдивы-Париж", 25000}, {"Мальдивы-Токио", 25000},
        {"Киев-Сочи", 15000}, {"Киев-Алтай", 15000}, {"Киев-Санкт-Петербург", 15000}, {"Киев-Дубай", 25000}, {"Киев-Карелия", 15000}, {"Киев-Мальдивы", 25000}, {"Киев-Сахара", 25000}, {"Киев-Париж", 25000}, {"Киев-Токио", 25000},
        {"Сахара-Сочи", 25000}, {"Сахара-Алтай", 25000}, {"Сахара-Санкт-Петербург", 25000}, {"Сахара-Дубай", 25000}, {"Сахара-Карелия", 25000}, {"Сахара-Мальдивы", 25000}, {"Сахара-Киев", 25000}, {"Сахара-Париж", 25000}, {"Сахара-Токио", 25000},
        {"Париж-Сочи", 25000}, {"Париж-Алтай", 25000}, {"Париж-Санкт-Петербург", 25000}, {"Париж-Дубай", 25000}, {"Париж-Карелия", 25000}, {"Париж-Мальдивы", 25000}, {"Париж-Киев", 25000}, {"Париж-Сахара", 25000}, {"Париж-Токио", 25000},
        {"Токио-Сочи", 25000}, {"Токио-Алтай", 25000}, {"Токио-Санкт-Петербург", 25000}, {"Токио-Дубай", 25000}, {"Токио-Карелия", 25000}, {"Токио-Мальдивы", 25000}, {"Токио-Киев", 25000}, {"Токио-Сахара", 25000}, {"Токио-Париж", 25000}
    };

    // Инициализируем ответы пользователя
    for (int i = 0; i < 7; i++) {
        userAnswers.append("");
    }

    // Загружаем сохранённые бронирования из JSON при инициализации
    loadFromJson();
}

void SurveyModel::setAnswer(int questionIndex, const QString &category) {
    userAnswers[questionIndex] = category;
}

void SurveyModel::resetAnswers() {
    userAnswers.clear();
    for (int i = 0; i < 7; i++) {
        userAnswers.append("");
    }
}

QVariantList SurveyModel::getSortedPlaces() {
    // Подсчитываем совпадения категорий
    QMap<QString, int> placeScores;
    for (const auto &place : places) {
        int score = 0;
        QStringList placeCategories = place["categories"].toStringList();
        for (const QString &answer : userAnswers) {
            if (placeCategories.contains(answer)) {
                score++;
            }
        }
        placeScores[place["name"].toString()] = score;
    }

    // Сортируем места по количеству совпадений
    QList<QPair<QString, int>> sortedPlaces;
    for (auto it = placeScores.constBegin(); it != placeScores.constEnd(); ++it) {
        sortedPlaces.append({it.key(), it.value()});
    }
    std::sort(sortedPlaces.begin(), sortedPlaces.end(),
              [](const QPair<QString, int> &a, const QPair<QString, int> &b) {
                  return b.second < a.second; // По убыванию
              });

    // Формируем результат для QML
    QVariantList result;
    for (const auto &place : sortedPlaces) {
        QVariantMap placeData;
        placeData["name"] = place.first;
        placeData["score"] = place.second;
        result.append(placeData);
    }
    return result;
}

QStringList SurveyModel::getOptionsForQuestion(int questionIndex) {
    switch (questionIndex) {
    case 0: // Климат
        return {"теплый", "умеренный", "холодный"};
    case 1: // Активность
        return {"активный", "пассивный"};
    case 2: // Бюджет
        return {"эконом", "средний", "премиум"};
    case 3: // Природные условия
        return {"море", "лес", "пустыня", "город", "степь", "горы"};
    case 4: // Контакт с фауной
        return {"с контактом с животными", "без контакта с животными"};
    case 5: // Культура
        return {"с культурными достопримечательностями", "без культурных достопримечательностей"};
    case 6: // Дальность
        return {"в пределах страны (РФ)", "соседние страны (страны бывшего СССР)", "остальной мир"};
    default:
        return {};
    }
}

void SurveyModel::bookTrip(const QString &departure, const QString &destination, const QString &departureDate, const QString &returnDate, const QStringList &travelers) {
    QVariantMap booking;
    booking["departure"] = departure;
    booking["destination"] = destination;
    booking["departureDate"] = departureDate;
    booking["returnDate"] = returnDate;
    booking["travelers"] = travelers;
    booking["cost"] = getTripCost(departure, destination);
    bookings.append(booking);
    emit bookingsChanged();
    saveToJson(); // Сохраняем в JSON после добавления
}

QVariantList SurveyModel::getBookings() {
    return bookings;
}

void SurveyModel::removeBooking(int index) {
    if (index >= 0 && index < bookings.size()) {
        bookings.removeAt(index);
        emit bookingsChanged();
        saveToJson(); // Сохраняем в JSON после удаления
    }
}

QStringList SurveyModel::getAllPlaces() {
    QStringList placeNames;
    for (const auto &place : places) {
        placeNames.append(place["name"].toString());
    }
    return placeNames;
}

QString SurveyModel::getPlaceDescription(const QString &placeName) {
    for (const auto &place : places) {
        if (place["name"].toString() == placeName) {
            return place["description"].toString();
        }
    }
    return "Описание не найдено.";
}

int SurveyModel::getTripCost(const QString &departure, const QString &destination) {
    if (departure == destination) {
        return 0; // Нельзя бронировать поездку в то же место
    }
    QString key = departure + "-" + destination;
    return tripCosts.value(key, 0); // Возвращаем 0, если маршрут не найден
}

void SurveyModel::saveToJson() {
    QJsonArray jsonArray;
    for (const QVariant &booking : bookings) {
        QVariantMap bookingMap = booking.toMap();
        QJsonObject jsonBooking;
        jsonBooking["departure"] = bookingMap["departure"].toString();
        jsonBooking["destination"] = bookingMap["destination"].toString();
        jsonBooking["departureDate"] = bookingMap["departureDate"].toString();
        jsonBooking["returnDate"] = bookingMap["returnDate"].toString();
        jsonBooking["cost"] = bookingMap["cost"].toInt();
        QJsonArray travelersArray;
        for (const QVariant &traveler : bookingMap["travelers"].toStringList()) {
            travelersArray.append(traveler.toString());
        }
        jsonBooking["travelers"] = travelersArray;
        jsonArray.append(jsonBooking);
    }

    QJsonDocument jsonDoc(jsonArray);
    QFile file("trips.json");
    if (file.open(QIODevice::WriteOnly)) {
        file.write(jsonDoc.toJson());
        file.close();
    }
}

void SurveyModel::loadFromJson() {
    QFile file("trips.json");
    if (file.open(QIODevice::ReadOnly)) {
        QJsonDocument jsonDoc = QJsonDocument::fromJson(file.readAll());
        file.close();
        if (!jsonDoc.isNull() && jsonDoc.isArray()) {
            bookings.clear();
            QJsonArray jsonArray = jsonDoc.array();
            for (const QJsonValue &value : jsonArray) {
                QJsonObject jsonBooking = value.toObject();
                QVariantMap booking;
                booking["departure"] = jsonBooking["departure"].toString();
                booking["destination"] = jsonBooking["destination"].toString();
                booking["departureDate"] = jsonBooking["departureDate"].toString();
                booking["returnDate"] = jsonBooking["returnDate"].toString();
                booking["cost"] = jsonBooking["cost"].toInt();
                QStringList travelers;
                QJsonArray travelersArray = jsonBooking["travelers"].toArray();
                for (const QJsonValue &traveler : travelersArray) {
                    travelers.append(traveler.toString());
                }
                booking["travelers"] = travelers;
                bookings.append(booking);
            }
            emit bookingsChanged();
        }
    }
}
