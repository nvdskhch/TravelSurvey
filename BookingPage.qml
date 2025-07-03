import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    property string destination: ""
    property string departure: ""
    property var selectedDepartureDate: new Date()
    property var selectedReturnDate: new Date()

    function formatDate(date) {
        return Qt.formatDate(date, "yyyy-MM-dd");
    }

    function createDate(year, month, day) {
        return new Date(year, month - 1, day);
    }

    function updateDestinationModel() {
        destinationInput.model = getFilteredDestinations();
        if (destination && destinationInput.model.indexOf(destination) === -1) {
            destination = destinationInput.model.length > 0 ? destinationInput.model[0] : "";
            destinationInput.currentIndex = destinationInput.model.length > 0 ? 0 : -1;
        } else {
            destinationInput.currentIndex = destination ? destinationInput.model.indexOf(destination) : 0;
        }
    }

    function getFilteredDestinations() {
        var allPlaces = surveyModel.getAllPlaces();
        return departure ? allPlaces.filter(function(place) { return place !== departure; }) : allPlaces;
    }

    function updateCost() {
        costText.text = departure && destination ? (surveyModel.getTripCost(departure, destination) > 0 ? "Стоимость поездки: " + surveyModel.getTripCost(departure, destination) + " руб." : "Маршрут недоступен") : "Выберите места отправления и назначения";
    }

    Component.onCompleted: {
        updateDestinationModel();
    }

    // Название страницы сверху посередине
    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        text: "Бронирование поездки"
        font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        anchors.topMargin: 30 // Учитываем высоту заголовка

        Text {
            Layout.fillWidth: true
            text: "Бронирование поездки из " + (departure || "не выбрано") + " в " + (destination || "не выбрано")
            font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
            wrapMode: Text.WordWrap
        }

        RowLayout {
            Layout.fillWidth: true
            Text {
                text: "Место отправления:"
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
            }
            ComboBox {
                id: departureInput
                model: surveyModel.getAllPlaces()
                Layout.fillWidth: true
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                Layout.preferredHeight: Math.min(mainWindow.height * 0.08, 40)
                onCurrentTextChanged: {
                    departure = currentText;
                    updateDestinationModel();
                    updateCost();
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Text {
                text: "Место назначения:"
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
            }
            ComboBox {
                id: destinationInput
                model: getFilteredDestinations()
                currentIndex: destination && model ? model.indexOf(destination) !== -1 ? model.indexOf(destination) : 0 : 0
                Layout.fillWidth: true
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                Layout.preferredHeight: Math.min(mainWindow.height * 0.08, 40)
                onCurrentTextChanged: {
                    destination = currentText;
                    updateCost();
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Text {
                text: "Дата вылета:"
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
            }
            ComboBox {
                id: departureDay
                model: Array.from({length: 31}, (_, i) => i + 1)
                currentIndex: selectedDepartureDate.getDate() - 1
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                Layout.preferredWidth: Math.min(mainWindow.width * 0.15, 80)
                Layout.preferredHeight: Math.min(mainWindow.height * 0.08, 40)
            }
            ComboBox {
                id: departureMonth
                model: ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
                currentIndex: selectedDepartureDate.getMonth()
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                Layout.preferredWidth: Math.min(mainWindow.width * 0.2, 100)
                Layout.preferredHeight: Math.min(mainWindow.height * 0.08, 40)
            }
            ComboBox {
                id: departureYear
                model: Array.from({length: 10}, (_, i) => new Date().getFullYear() + i)
                currentIndex: 0
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                Layout.preferredWidth: Math.min(mainWindow.width * 0.15, 80)
                Layout.preferredHeight: Math.min(mainWindow.height * 0.08, 40)
            }
            onVisibleChanged: {
                if (visible) {
                    selectedDepartureDate = createDate(departureYear.currentText, departureMonth.currentIndex + 1, departureDay.currentText);
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Text {
                text: "Дата прилёта:"
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
            }
            ComboBox {
                id: returnDay
                model: Array.from({length: 31}, (_, i) => i + 1)
                currentIndex: selectedReturnDate.getDate() - 1
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                Layout.preferredWidth: Math.min(mainWindow.width * 0.15, 80)
                Layout.preferredHeight: Math.min(mainWindow.height * 0.08, 40)
            }
            ComboBox {
                id: returnMonth
                model: ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
                currentIndex: selectedReturnDate.getMonth()
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                Layout.preferredWidth: Math.min(mainWindow.width * 0.2, 100)
                Layout.preferredHeight: Math.min(mainWindow.height * 0.08, 40)
            }
            ComboBox {
                id: returnYear
                model: Array.from({length: 10}, (_, i) => new Date().getFullYear() + i)
                currentIndex: 0
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                Layout.preferredWidth: Math.min(mainWindow.width * 0.15, 80)
                Layout.preferredHeight: Math.min(mainWindow.height * 0.08, 40)
            }
            onVisibleChanged: {
                if (visible) {
                    selectedReturnDate = createDate(returnYear.currentText, returnMonth.currentIndex + 1, returnDay.currentText);
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Text {
                text: "ФИО путешественников (по одному на строку):"
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
            }
            TextArea {
                id: travelersInput
                Layout.fillWidth: true
                Layout.preferredHeight: Math.min(mainWindow.height * 0.2, 100)
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)

                Text {
                    anchors.fill: parent
                    text: "Иванов Иван Иванович\nПетров Пётр Петрович"
                    color: "gray"
                    font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                    visible: travelersInput.text.length === 0
                    wrapMode: Text.WordWrap
                }

                onTextChanged: {
                    if (text.length > 0) {
                        placeholderText = "";
                    }
                }
            }
        }

        Text {
            id: costText
            Layout.fillWidth: true
            text: departure && destination ? (surveyModel.getTripCost(departure, destination) > 0 ? "Стоимость поездки: " + surveyModel.getTripCost(departure, destination) + " руб." : "Маршрут недоступен") : "Выберите места отправления и назначения"
            font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
            wrapMode: Text.WordWrap
        }

        Text {
            id: errorMessage
            color: "red"
            text: ""
            font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
            visible: false
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10
            Button {
                text: "Забронировать"
                width: Math.min(mainWindow.width * 0.25, 150)
                height: Math.min(mainWindow.height * 0.1, 50)
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                onClicked: {
                    if (!departure || !destination) {
                        errorMessage.text = "Выберите места отправления и назначения!";
                        errorMessage.visible = true;
                        return;
                    }
                    if (departure === destination) {
                        errorMessage.text = "Место отправления и назначения не могут совпадать!";
                        errorMessage.visible = true;
                        return;
                    }
                    if (surveyModel.getTripCost(departure, destination) === 0) {
                        errorMessage.text = "Маршрут недоступен!";
                        errorMessage.visible = true;
                        return;
                    }

                    selectedDepartureDate = createDate(departureYear.currentText, departureMonth.currentIndex + 1, departureDay.currentText);
                    selectedReturnDate = createDate(returnYear.currentText, returnMonth.currentIndex + 1, returnDay.currentText);

                    if (selectedReturnDate < selectedDepartureDate) {
                        errorMessage.text = "Дата прилёта не может быть раньше даты вылета!";
                        errorMessage.visible = true;
                        return;
                    }

                    errorMessage.visible = false;

                    var travelers = travelersInput.text.split("\n").filter(name => name.trim() !== "");
                    surveyModel.bookTrip(departure, destination,
                                         formatDate(selectedDepartureDate),
                                         formatDate(selectedReturnDate),
                                         travelers);
                    stackView.showTrips();
                }
            }
            Button {
                text: "Отмена"
                width: Math.min(mainWindow.width * 0.25, 150)
                height: Math.min(mainWindow.height * 0.1, 50)
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                onClicked: {
                    stackView.pop();
                }
            }
        }
    }
}
