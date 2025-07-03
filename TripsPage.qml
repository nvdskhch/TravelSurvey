import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    // Название страницы сверху посередине
    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        text: "Запланированные путешествия"
        font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            anchors.topMargin: 30 // Учитываем высоту заголовка

            Text {
                Layout.fillWidth: true
                text: "Запланированные путешествия:"
                font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: surveyModel.getBookings()
                delegate: ItemDelegate {
                    width: parent.width
                    height: Math.min(mainWindow.height * 0.2, 100)
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 5
                        ColumnLayout {
                            Text {
                                text: "Из: " + modelData.departure + " в: " + modelData.destination
                                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                            }
                            Text {
                                text: "Даты: " + modelData.departureDate + " - " + modelData.returnDate
                                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                            }
                            Text {
                                text: "Путешественники: " + modelData.travelers.join(", ")
                                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                                wrapMode: Text.WordWrap
                            }
                            Text {
                                text: "Стоимость: " + modelData.cost + " руб."
                                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                            }
                        }
                        Button {
                            text: "Удалить"
                            width: Math.min(mainWindow.width * 0.15, 80)
                            height: Math.min(mainWindow.height * 0.08, 40)
                            font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                            onClicked: {
                                surveyModel.removeBooking(index);
                            }
                        }
                    }
                }
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignVCenter

            Button {
                text: "На главную"
                width: Math.min(mainWindow.width * 0.3, 200)
                height: Math.min(mainWindow.height * 0.15, 70)
                font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
                onClicked: {
                    stackView.goHome();
                }
            }
        }
    }
}
