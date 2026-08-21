#pragma once

#include <QObject>

class TaskManager;

class Task;

class OperationStatus;

class TaskWorker : public QObject
{
    Q_OBJECT

public:
    explicit TaskWorker(QObject *parent = nullptr);

public slots:
    void addTask(const QString &text);

    void deleteTask(int id);

    void updateStatus(int id, bool completed);

    void updateTitle(int id, const QString &title);

    void clearDatabase();

    void init();

    void loadTasks();

private:
    TaskManager *manager = nullptr;

signals:
    void taskReady(const Task &task);

    void taskDeleted(int id);

    void taskTitleUpdated(int id, const QString &title);

    void taskStatusUpdated(int id, bool completed);

    void databaseCleared();

    void tasksLoaded(const QVector<Task> &tasks);

    void operationStatus(OperationStatus status);
};
