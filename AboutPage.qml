import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    // Название страницы сверху посередине
    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        text: "О приложении"
        font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        anchors.topMargin: 30 // Учитываем высоту заголовка

        Text {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Travel Survey — это приложение для планирования путешествий. Оно помогает подобрать идеальное место для отдыха на основе ваших предпочтений.\n\n" +
                  "Возможности приложения:\n" +
                  "- Пройдите анкету, чтобы получить рекомендации по местам для путешествия.\n" +
                  "- Ознакомьтесь с доступными локациями и их описанием.\n" +
                  "- Запланируйте путешествие, выбрав место, даты и указав путешественников.\n" +
                  "- Просматривайте и управляйте списком запланированных поездок.\n\n" +
                  "Как пользоваться:\n" +
                  "1. Нажмите 'Начать анкету' на главной странице, чтобы пройти опрос.\n" +
                  "2. Выберите 'Доступные локации', чтобы ознакомиться с местами.\n" +
                  "3. Используйте 'Запланировать путешествие' для ручного бронирования.\n" +
                  "4. Перейдите в 'Запланированные путешествия', чтобы увидеть свои поездки."
            font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
            wrapMode: Text.WordWrap
        }

        Button {
            text: "Вернуться на главную"
            Layout.alignment: Qt.AlignHCenter
            width: Math.min(mainWindow.width * 0.3, 200)
            height: Math.min(mainWindow.height * 0.15, 70)
            font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
            onClicked: {
                stackView.goHome();
            }
        }
    }
}
