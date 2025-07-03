import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    // Название страницы сверху посередине
    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        text: "Travel Survey"
        font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Button {
                text: "Начать анкету"
                anchors.centerIn: parent
                width: Math.min(mainWindow.width * 0.5, 400)
                height: Math.min(mainWindow.height * 0.15, 80)
                font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
                onClicked: {
                    stackView.startSurvey();
                }
            }
        }
    }

    ColumnLayout {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 5
        spacing: 5

        // Устанавливаем одинаковый размер для всех кнопок справа
        Button {
            text: "Запланированные\nпутешествия"
            width: Math.min(mainWindow.width * 0.25, 150)
            height: Math.min(mainWindow.height * 0.1, 50)
            font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
            contentItem: Text {
                text: parent.text
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
            }
            onClicked: {
                stackView.showTrips();
            }
        }

        Button {
            text: "Запланировать\nпутешествие"
            width: Math.min(mainWindow.width * 0.25, 150)
            height: Math.min(mainWindow.height * 0.1, 50)
            font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
            contentItem: Text {
                text: parent.text
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
            }
            onClicked: {
                stackView.manualBooking();
            }
        }
    }
}
