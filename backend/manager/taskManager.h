#pragma once

#include <QObject>
#include "../database/database.h"
#include <QtQml/qqml.h>
#include "task/operationStatus.h"

class Task;

class TaskManager : public QObject {

    Q_OBJECT

public:
    explicit TaskManager(QObject *parent = nullptr);

private:
    Database *database = nullptr;

public slots:
    OperationStatus addTask(const QString &title, Task &task);

    OperationStatus deleteTask(int id);

    OperationStatus updateStatus(int id, bool completed);

    OperationStatus updateTitle(int id, const QString &title);

    OperationStatus clearDatabase();

    QVector<Task> loadTasks();

    QVector<Task> loadTasksByPage(int offset, int limit);

    int totalTasksCount();

signals:
    void tasksLoaded(const QVector<Task> &task);

    void tasksCount(int count);

};
