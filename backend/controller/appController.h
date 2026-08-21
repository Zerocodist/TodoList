#pragma once

#include "model/listModel.h"
#include "proxyModel/proxyModel.h"
#include <QObject>
#include <QThread>

class TaskWorker;

class Task;

class AppController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(ListModelCpp *model READ model CONSTANT)

    Q_PROPERTY(ProxyModel *proxyModel READ proxyModel CONSTANT)

public:
    explicit AppController(QObject *parent = nullptr);

    ListModelCpp *model();

    ProxyModel *proxyModel();

    ~AppController();

private:
    TaskWorker *worker = nullptr;

    QThread thread;

    ListModelCpp m_model;

    ProxyModel m_proxyModel;

signals:
    void addTaskSignal(const QString &title);

    void deleteTaskSignal(int id);

    void searchTaskSignal(const QString &title);

    void updateStatusSignal(int id, bool completed);

    void updateTitleSignal(int id, const QString &title);

    void clearDatabaseSignal();

    void loadLogsSignal();

    void operationStatus(const QString &title);

public slots:
    Q_INVOKABLE void addTask(const QString &title);

    Q_INVOKABLE void deleteTask(int id);

    Q_INVOKABLE void search(const QString &title);

    Q_INVOKABLE void updateStatus(int id, bool completed);

    Q_INVOKABLE void updateTitle(int id, const QString &title);

    Q_INVOKABLE void clearDatabase();

    Q_INVOKABLE void clearModel();

    Q_INVOKABLE void loadLogs();

};
