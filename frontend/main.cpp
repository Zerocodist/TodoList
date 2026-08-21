#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include <qqml.h>
#include "controller/appController.h"
#include "task/operationStatus.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("Fusion");

    QQmlApplicationEngine engine;

    qRegisterMetaType<Task>("Task");

    qRegisterMetaType<OperationStatus>("Status");

    AppController controller;

    engine.rootContext()->setContextProperty("AppController", &controller);

    engine.loadFromModule("TodoList", "Main");

    if(engine.rootObjects().isEmpty()) {
        return -1;
    }

    return QCoreApplication::exec();
}
