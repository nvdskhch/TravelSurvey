#ifndef SURVEYMODEL_H
#define SURVEYMODEL_H

#include <QObject>
#include <QDate>
#include <QFile>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

class SurveyModel : public QObject {
    Q_OBJECT
public:
    explicit SurveyModel(QObject *parent = nullptr);

public slots:
    void setAnswer(int questionIndex, const QString &category);
    void resetAnswers();
    QVariantList getSortedPlaces();
    QStringList getOptionsForQuestion(int questionIndex);
    void bookTrip(const QString &departure, const QString &destination, const QString &departureDate, const QString &returnDate, const QStringList &travelers);
    QVariantList getBookings();
    void removeBooking(int index);
    QStringList getAllPlaces();
    QString getPlaceDescription(const QString &placeName);
    int getTripCost(const QString &departure, const QString &destination);
    void saveToJson();
    void loadFromJson();

signals:
    void bookingsChanged();

private:
    QStringList categories;
    QList<QVariantMap> places;
    QStringList userAnswers;
    QVariantList bookings;
    QMap<QString, int> tripCosts;
};

#endif // SURVEYMODEL_H
