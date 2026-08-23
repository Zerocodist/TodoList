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

    void loadTasksByPage(int offset, int limit);

    void totalTasksCount();

private:
    TaskManager *manager = nullptr;

signals:
    void taskReady(const Task &task);

    void taskDeleted(int id);

    void taskTitleUpdated(int id, const QString &title);

    void taskStatusUpdated(int id, bool completed);

    void databaseCleared();

    void tasksLoaded(const QVector<Task> &tasks);

    void tasksLoadedByPage(const QVector<Task> &tasks);

    void tasksCount(int count);

    void operationStatus(OperationStatus status);
};
