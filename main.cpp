#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "surveymodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qputenv("QT_QUICK_CONTROLS_STYLE", "Material");

    SurveyModel surveyModel;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("surveyModel", &surveyModel);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
