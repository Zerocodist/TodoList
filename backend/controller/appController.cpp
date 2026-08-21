#include "controller/appController.h"
#include "worker/taskWorker.h"
#include "task/operationStatus.h"


AppController::AppController(QObject *parent)
    : QObject(parent)
{
    worker = new TaskWorker();

    worker->moveToThread(&thread);

    connect(&thread, &QThread::finished,
            worker,
            &TaskWorker::deleteLater);

    connect(this, &AppController::addTaskSignal,
            worker,
            &TaskWorker::addTask);

    connect(this, &AppController::deleteTaskSignal,
            worker,
            &TaskWorker::deleteTask);

    connect(this, &AppController::updateStatusSignal,
            worker,
            &TaskWorker::updateStatus);

    connect(this, &AppController::updateTitleSignal,
            worker,
            &TaskWorker::updateTitle);

    connect(this, &AppController::clearDatabaseSignal,
            worker,
            &TaskWorker::clearDatabase);

    connect(this, &AppController::loadLogsSignal,
            worker,
            &TaskWorker::loadTasks);

    connect(worker, &TaskWorker::tasksLoaded,
            this,
            [this](const QVector<Task> &tasks)
    {
        m_model.setTasks(tasks);
    });

    connect(worker, &TaskWorker::operationStatus,
            this,
            [this](const OperationStatus &status)
    {
                emit operationStatus(status.message);
    });

    connect(worker, &TaskWorker::taskReady,
            this,
            [this](const Task &task)
    {
        m_model.addTask(task);
    });

    connect(worker, &TaskWorker::taskDeleted,
            this,
            [this](int id)
    {
        m_model.deleteTask(id);
    });

    connect(worker, &TaskWorker::taskStatusUpdated,
            this,
            [this](int id, bool completed)
    {
        m_model.updateStatus(id, completed);
    });

    connect(worker, &TaskWorker::taskTitleUpdated,
            this,
            [this](int id, const QString &title)
    {
        m_model.updateTitle(id, title);
    });

    connect(&m_model, &ListModelCpp::operationStatus,
            this,
            &AppController::operationStatus);

    m_proxyModel.setSourceModel(&m_model);

    thread.start();

    QMetaObject::invokeMethod(
        worker,
        "init",
        Qt::QueuedConnection);

}


AppController::~AppController()
{
    thread.quit();
    thread.wait();
}


ListModelCpp *AppController::model()
{
    return &m_model;
}


ProxyModel *AppController::proxyModel()
{
    return &m_proxyModel;
}


void AppController::addTask(const QString &title)
{
    emit addTaskSignal(title);
}


void AppController::deleteTask(int id)
{
    emit deleteTaskSignal(id);
}


void AppController::search(const QString &title)
{
    m_proxyModel.setSearchText(title);
}


void AppController::updateStatus(int id, bool completed)
{
    emit updateStatusSignal(id, completed);
}


void AppController::updateTitle(int id, const QString &title)
{
    emit updateTitleSignal(id, title);
}


void AppController::clearDatabase()
{
    emit clearDatabaseSignal();
}

void AppController::clearModel()
{
    m_model.clearAll();
}


void AppController::loadLogs()
{
    emit loadLogsSignal();
}
