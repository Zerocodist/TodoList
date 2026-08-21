#include "database.h"
#include "task/task.h"
#include <QDebug>

Database::Database(DatabaseMode mode, QObject *parent)
    : QObject(parent),
    mode(mode)
{

    connectionName =
        mode == DatabaseMode::Test
            ? QUuid::createUuid().toString()
            : "main_connection";

    databaseName =
        mode == DatabaseMode::Test
            ? ":memory:"
            : "tasks.db";


    initDatabase();
}

void Database::createTable()
{
    QSqlQuery query(db);

    if(!query.exec(
            "CREATE TABLE IF NOT EXISTS tasks ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title TEXT NOT NULL, "
            "completed INTEGER NOT NULL DEFAULT 0)"
            )) {
        qWarning() << "Create table failed!: " << query.lastError().text();
        qWarning() << QSqlDatabase::drivers();
    }

}

void Database::initDatabase() {
    if(!openDatabase()) return;

    createTable();
}

bool Database::openDatabase()
{
    if(QSqlDatabase::contains(connectionName))
    {
        db = QSqlDatabase::database(connectionName);
    }

    else
    {
        db = QSqlDatabase::addDatabase("QSQLITE", connectionName);
    }

    db.setDatabaseName(databaseName);

    if(!db.open())
    {
        qWarning() << "Error database not open: "
                   << db.lastError().text();

        return false;
    }


    return true;
}

int Database::addTask(const QString &title)
{
    QSqlQuery query(db);

    query.prepare(
        "INSERT INTO tasks (title, completed) "
        "VALUES (:title, :completed)"
        );

    query.bindValue(":title", title);
    query.bindValue(":completed", 0);

    if(!query.exec()) {
        qWarning() << "Add task failed: "
                   << query.lastError().text();
        return -1;
    }

    int newId = query.lastInsertId().toInt();

    return newId;
}


bool Database::deleteTask(int id)
{
    QSqlQuery query(db);

    query.prepare("DELETE FROM tasks WHERE id = :id");

    query.bindValue(":id", id);

    if(!query.exec())
    {
        qWarning() << "Cannot delete task in database: "
                   << query.lastError().text();

        return false;
    }

    return query.numRowsAffected() > 0;
}


bool Database::updateStatus(int id, bool completed)
{
    QSqlQuery query(db);

    query.prepare(
        "UPDATE tasks "
        "SET completed = :completed "
        "WHERE id = :id"
        );

    query.bindValue(":completed", completed);

    query.bindValue(":id", id);

    if(!query.exec())
    {
        qWarning() << "Error database can't update status: "
                   << query.lastError().text();

        return false;
    }

    return true;
}

bool Database::updateTitle(int id, const QString &title)
{
    QSqlQuery query(db);

    query.prepare(
        "UPDATE tasks "
        "SET title = :title "
        "WHERE id = :id"
        );

    query.bindValue(":title", title);

    query.bindValue(":id", id);

    if(!query.exec())
    {
        qWarning() << "Error database can't update title: "
                   << query.lastError().text();

        return false;
    }

    return true;
}

bool Database::clearAll()
{
    QSqlQuery query(db);

    if(!query.exec("DELETE FROM tasks"))
    {
        qWarning() << "Error database can't delete all tasks: "
                   << query.lastError().text();

        return false;
    }

    return true;
}

QSqlDatabase Database::connection() const {
    return db;
}

Database::~Database()
{
    QString name = connectionName;

    if(db.isOpen()) db.close();

    db = QSqlDatabase();

    QSqlDatabase::removeDatabase(name);
}


QVector<Task> Database::loadLogs()
{
    QVector<Task> results;

    QSqlQuery query(db);

    query.prepare(
    "SELECT id, title, completed "
    "FROM tasks"
    );

    if(!query.exec())
    {
        qDebug() << "Error can't load logs: "
                 << query.lastError().text();

        return {};
    }

    while(query.next())
    {
        Task task;

        task.id = query.value(0).toInt();
        task.title = query.value(1).toString();
        task.completed = query.value(2).toBool();

        results.append(task);
    }

    return results;
}