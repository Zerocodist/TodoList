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

    Q_PROPERTY(int currentPage READ currentPage NOTIFY currentPageChanged)

    Q_PROPERTY(int totalPages READ totalPages NOTIFY totalPagesChanged)

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

    int m_currentPage = 1;

    int m_totalPages = 0;

    int m_pageSize = 0;

    void updateTotalPages(int totalTasks, int limit);

    void resetPagination();

signals:
    void addTaskSignal(const QString &title);

    void deleteTaskSignal(int id);

    void searchTaskSignal(const QString &title);

    void updateStatusSignal(int id, bool completed);

    void updateTitleSignal(int id, const QString &title);

    void clearDatabaseSignal();

    void loadTasksSignal();

    void operationStatus(const QString &title);

    void totalPagesChanged();

    void currentPageChanged();

    void loadPageRequest(int offset, int limit);

    void requestTotalTasksCount();

public slots:
    Q_INVOKABLE void addTask(const QString &title);

    Q_INVOKABLE void deleteTask(int id);

    Q_INVOKABLE void search(const QString &title);

    Q_INVOKABLE void updateStatus(int id, bool completed);

    Q_INVOKABLE void updateTitle(int id, const QString &title);

    Q_INVOKABLE void clearDatabase();

    Q_INVOKABLE void clearModel();

    Q_INVOKABLE void loadTasks();

    Q_INVOKABLE void loadTasksByPage(int offset, int limit);

    Q_INVOKABLE void previousPage();

    Q_INVOKABLE void nextPage();

    Q_INVOKABLE void loadPage(int page);

    int currentPage() const;

    int totalPages() const;

};
