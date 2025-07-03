import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    // Название страницы сверху посередине
    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        text: "Результаты анкеты"
        font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        anchors.topMargin: 30 // Учитываем высоту заголовка

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text {
                Layout.fillWidth: true
                text: "Рекомендованные места:"
                font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: surveyModel.getSortedPlaces()
                delegate: ItemDelegate {
                    width: parent.width
                    height: Math.min(mainWindow.height * 0.1, 50)
                    RowLayout {
                        anchors.fill: parent
                        Text {
                            text: modelData.name + " (совпадений: " + modelData.score + ")"
                            font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                            Layout.fillWidth: true
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    onClicked: {
                        stackView.push("BookingPage.qml", { destination: modelData.name });
                    }
                }
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignVCenter
            spacing: 5

            Button {
                text: "На главную"
                width: Math.min(mainWindow.width * 0.25, 150)
                height: Math.min(mainWindow.height * 0.1, 50)
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                onClicked: {
                    stackView.goHome();
                }
            }

            Button {
                text: "Начать заново"
                width: Math.min(mainWindow.width * 0.25, 150)
                height: Math.min(mainWindow.height * 0.1, 50)
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                onClicked: {
                    stackView.resetSurvey();
                }
            }
        }
    }
}
