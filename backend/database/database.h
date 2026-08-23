#pragma once

#include <QObject>
#include <QtSql/QtSql>
#include "databaseMode.h"

class Task;

class Database : public QObject {

    Q_OBJECT

public:
    explicit Database(DatabaseMode mode = DatabaseMode::Production, QObject *parent = nullptr);

    void initDatabase();

    bool openDatabase();

    void createTable();

    QSqlDatabase connection() const;

    int totalTasksCount();

    ~Database();

private:
    QSqlDatabase db;

    QString databaseName;

    QString connectionName;

    DatabaseMode mode;

public slots:
    int addTask(const QString &title);

    bool deleteTask(int id);

    bool updateStatus(int id, bool completed);

    bool updateTitle(int id, const QString &title);

    bool clearAll();

    QVector<Task> loadTasks();

    QVector<Task> loadTasksByPage(int offset, int limit);

signals:
    void pagesCount(int count);
};

