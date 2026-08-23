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

    connect(this, &AppController::loadTasksSignal,
            worker,
            &TaskWorker::loadTasks);

    connect(worker, &TaskWorker::tasksLoadedByPage,
            this,
            [this](const QVector<Task> &tasks)
            {
                m_model.setTasks(tasks);
            });

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

    connect(worker, &TaskWorker::tasksCount,
            this,
            [this](int count)
    {
        updateTotalPages(count, m_pageSize);
    });

    connect(this, &AppController::requestTotalTasksCount,
            worker, &TaskWorker::totalTasksCount);

    connect(this, &AppController::loadPageRequest,
            worker, &TaskWorker::loadTasksByPage);

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

    emit requestTotalTasksCount();
}


void AppController::deleteTask(int id)
{
    emit deleteTaskSignal(id);

    emit requestTotalTasksCount();
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

    emit requestTotalTasksCount();
}

void AppController::clearModel()
{
    m_model.clearAll();
}


void AppController::loadTasks()
{
    m_pageSize = 0;

    resetPagination();

    emit loadTasksSignal();
}


void AppController::loadTasksByPage(int offset, int limit)
{
    if(limit <= 0)
        return;

    m_pageSize = limit;

    m_currentPage = offset / m_pageSize + 1;

    emit loadPageRequest(offset, m_pageSize);

    emit requestTotalTasksCount();

    emit currentPageChanged();
}


int AppController::totalPages() const
{
    return m_totalPages;
}


int AppController::currentPage() const
{
    return m_currentPage;
}


void AppController::updateTotalPages(int totalTasks, int limit)
{
    if(limit <= 0)
    {

        m_totalPages = 1;
        m_currentPage = 1;

        emit totalPagesChanged();
        emit currentPageChanged();

        return;
    }

    m_totalPages = (totalTasks + limit -1) / limit;

    if(m_totalPages == 0)
    {
        m_currentPage = 1;
    }

    else if(m_currentPage > m_totalPages)
    {
        m_currentPage = m_totalPages;
    }

    emit totalPagesChanged();

    emit currentPageChanged();
}



void AppController::loadPage(int page)
{
    if(page < 1)
        return;

    if(m_totalPages > 0 && page > m_totalPages)
        return;

    if(m_pageSize <= 0)
        return;

    m_currentPage = page;

    int offset = (m_currentPage - 1) * m_pageSize;

    emit loadPageRequest(offset, m_pageSize);

    emit currentPageChanged();
}

void AppController::resetPagination()
{
    m_currentPage = 1;

    m_totalPages = 0;

    emit currentPageChanged();

    emit totalPagesChanged();
}


void AppController::previousPage()
{
    loadPage(m_currentPage - 1);
}


void AppController::nextPage()
{
    loadPage(m_currentPage + 1);
}
