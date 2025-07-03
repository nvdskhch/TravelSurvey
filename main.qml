import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 600
    height: 400
    title: "Travel Survey"

    property int currentQuestion: 0

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "HomePage.qml"

        function resetSurvey() {
            mainWindow.currentQuestion = 0;
            surveyModel.resetAnswers();
            clear();
            push("SurveyPage.qml", { currentQuestion: 0 });
        }

        function startSurvey() {
            clear();
            push("SurveyPage.qml", { currentQuestion: 0 });
        }

        function showTrips() {
            clear();
            push("TripsPage.qml");
        }

        function goHome() {
            clear();
            push("HomePage.qml");
        }

        function manualBooking() {
            clear();
            push("ManualBookingPage.qml");
        }
    }
}
