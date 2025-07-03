import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    property string selectedPlace: ""

    // Название страницы сверху посередине
    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        text: "Доступные локации"
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
                text: "Доступные локации:"
                font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: surveyModel.getAllPlaces()
                delegate: ItemDelegate {
                    width: parent.width
                    height: Math.min(mainWindow.height * 0.1, 50)
                    Text {
                        anchors.fill: parent
                        text: modelData
                        font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        selectedPlace = modelData;
                    }
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: selectedPlace !== ""

            Item {
                Layout.fillHeight: true
            }

            Text {
                Layout.fillWidth: true
                text: selectedPlace
                font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                Layout.fillWidth: true
                text: surveyModel.getPlaceDescription(selectedPlace)
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
            }

            Button {
                text: "Запланировать"
                Layout.alignment: Qt.AlignHCenter
                width: Math.min(mainWindow.width * 0.25, 150)
                height: Math.min(mainWindow.height * 0.1, 50)
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                onClicked: {
                    stackView.push("BookingPage.qml", { destination: selectedPlace });
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }

    ColumnLayout {
        Layout.alignment: Qt.AlignVCenter
        anchors.right: parent.right
        anchors.margins: 10

        Button {
            text: "На главную"
            width: Math.min(mainWindow.width * 0.25, 150)
            height: Math.min(mainWindow.height * 0.1, 50)
            font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
            onClicked: {
                stackView.goHome();
            }
        }
    }
}
