import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: surveyPage
    property int currentQuestion: 0

    // Название страницы сверху посередине
    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        text: "Анкета"
        font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        anchors.topMargin: 30 // Учитываем высоту заголовка

        Text {
            Layout.fillWidth: true
            text: "Вопрос " + (currentQuestion + 1) + " из 7: " + questions[currentQuestion]
            font.pixelSize: Math.min(mainWindow.width * 0.03, 20)
            wrapMode: Text.WordWrap
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: surveyModel.getOptionsForQuestion(currentQuestion)
            delegate: Button {
                width: parent.width
                height: Math.min(mainWindow.height * 0.1, 50)
                text: modelData
                font.pixelSize: Math.min(mainWindow.width * 0.025, 16)
                onClicked: {
                    surveyModel.setAnswer(currentQuestion, modelData);
                    if (currentQuestion < 6) {
                        surveyPage.currentQuestion++;
                    } else {
                        stackView.push("ResultPage.qml");
                    }
                }
            }
        }
    }

    property var questions: [
        "В каком климате вы бы хотели побывать?",
        "Насколько активный отдых вы бы хотели?",
        "Какой у вас выделен бюджет?",
        "В каких природных условиях вы бы хотели побывать?",
        "Вы бы хотели иметь контакт с местной фауной?",
        "Хотели бы вы посетить местные культурные достопримечательности?",
        "Как далеко вы готовы путешествовать?"
    ]
}
