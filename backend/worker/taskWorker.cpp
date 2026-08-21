#include "worker/taskWorker.h"
#include "manager/taskManager.h"
#include "task/task.h"

TaskWorker::TaskWorker(QObject *parent)
    : QObject(parent)
{

}


void TaskWorker::init()
{
    manager = new TaskManager(this);
}


void TaskWorker::addTask(const QString &title)
{
    Task task;

    const OperationStatus status = manager->addTask(title, task);

    emit operationStatus(status);

    if(!status.success)
        return;

    emit taskReady(task);
}


void TaskWorker::deleteTask(int id)
{
    OperationStatus status = manager->deleteTask(id);

    emit operationStatus(status);

    if(!status.success)
        return;

    emit taskDeleted(id);
}


void TaskWorker::updateStatus(int id, bool completed)
{
    OperationStatus status = manager->updateStatus(id, completed);

    emit operationStatus(status);

    if(!status.success)
        return;

    emit taskStatusUpdated(id, completed);
}


void TaskWorker::updateTitle(int id, const QString &title)
{
    OperationStatus status = manager->updateTitle(id, title);

    emit operationStatus(status);

    if(!status.success)
        return;

    emit taskTitleUpdated(id, title);
}


void TaskWorker::clearDatabase()
{
   OperationStatus status = manager->clearDatabase();

   emit operationStatus(status);

   if(!status.success)
       return;
}


void TaskWorker::loadTasks()
{
    QVector<Task> tasks = manager->loadLogs();

    emit tasksLoaded(tasks);
}