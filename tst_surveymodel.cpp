#include <QtTest>
#include <QObject>
#include "surveymodel.h"

class TestSurveyModel : public QObject {
    Q_OBJECT

private slots:
    void testSetAnswer() {
        SurveyModel model;
        model.setAnswer(0, "теплый");
        QCOMPARE(model.getOptionsForQuestion(0).contains("теплый"), true);
        model.setAnswer(0, "холодный");
        QCOMPARE(model.getOptionsForQuestion(0).contains("холодный"), true);
    }

    void testGetOptionsForQuestion() {
        SurveyModel model;
        QStringList options = model.getOptionsForQuestion(0);
        QCOMPARE(options, QStringList({"теплый", "умеренный", "холодный"}));
        options = model.getOptionsForQuestion(3);
        QCOMPARE(options, QStringList({"море", "лес", "пустыня", "город", "степь", "горы"}));
    }

    void testGetSortedPlaces() {
        SurveyModel model;
        model.setAnswer(0, "теплый");
        model.setAnswer(2, "премиум");
        model.setAnswer(3, "море");
        QVariantList sortedPlaces = model.getSortedPlaces();
        QVERIFY(!sortedPlaces.isEmpty());
        QCOMPARE(sortedPlaces[0].toMap()["name"].toString(), "Мальдивы");
    }

    void testBookTrip() {
        SurveyModel model;
        QStringList travelers = {"Иванов Иван"};
        model.bookTrip("Сочи", "Дубай", "2025-07-10", "2025-07-20", travelers);
        QVariantList bookings = model.getBookings();
        QCOMPARE(bookings.size(), 1);
        QCOMPARE(bookings[0].toMap()["departure"].toString(), "Сочи");
        QCOMPARE(bookings[0].toMap()["destination"].toString(), "Дубай");
        QCOMPARE(bookings[0].toMap()["cost"].toInt(), 25000);
    }

    void testGetTripCost() {
        SurveyModel model;
        QCOMPARE(model.getTripCost("Сочи", "Дубай"), 25000);
        QCOMPARE(model.getTripCost("Сочи", "Сочи"), 0);
        QCOMPARE(model.getTripCost("Неизвестный", "Дубай"), 0);
    }
};

QTEST_MAIN(TestSurveyModel)
#include "tst_surveymodel.moc"
