#include "taskManager.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include "task/task.h"
#include "task/operationStatus.h"

TaskManager::TaskManager(QObject *parent)
    : QObject(parent)
{
    database = new Database(DatabaseMode::Production, this);
}

OperationStatus TaskManager::addTask(const QString &title, Task &task)
{
    const int id = database->addTask(title);

    if(id == -1)
        return OperationStatus::fail(OperationType::AddTask, id, "Task add failure!");

    task.id = id;

    task.title = title;

    task.completed = false;

    return OperationStatus::ok(OperationType::AddTask, id, "Task add successfull");
}


OperationStatus TaskManager::deleteTask(int id)
{
    if(database->deleteTask(id))
        return OperationStatus::ok(OperationType::DeleteTask, id, "Deleted successfull");

    return OperationStatus::fail(OperationType::DeleteTask, id, "Deleted failure!");
}


OperationStatus TaskManager::updateStatus(int id, bool completed)
{
    if(database->updateStatus(id, completed))
        return OperationStatus::ok(OperationType::UpdateStatus, id, "Task status updated successfull");

    return OperationStatus::fail(OperationType::UpdateStatus, id, "Task status updated failure!");
}


OperationStatus TaskManager::updateTitle(int id, const QString &title)
{
    if(title.length() < 1)
        return OperationStatus::fail(OperationType::UpdateTitle, id, "Error title can't be empty!");

    if(database->updateTitle(id, title))
    {
        qDebug() << "Title successfully updated";

        return OperationStatus::ok(OperationType::UpdateTitle, id, "Title successfully updated");
    }

    return OperationStatus::fail(OperationType::UpdateTitle, id, "Title updated failure!");
}


OperationStatus TaskManager::clearDatabase()
{
    if(database->clearAll())
        return OperationStatus::ok(OperationType::ClearDatabase, -1, "Database successfully cleared");

    return OperationStatus::fail(OperationType::ClearDatabase, -1, "Error database clear failed!");
}


QVector<Task> TaskManager::loadLogs()
{
    QVector<Task> results = database->loadLogs();

    if(results.isEmpty())
    {
        qDebug() << "Database loads 0 logs";

        return {};
    }

    return results;
}