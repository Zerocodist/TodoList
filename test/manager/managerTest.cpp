#include "../manager/managerTest.h"


    void TaskManagerTest::init()
    {
        db = new Database(DatabaseMode::Test);
        tm = new TaskManager(*db);
        qDebug() << QSqlDatabase::connectionNames();
    }

    void TaskManagerTest::cleanup()
    {
        delete tm;
        tm = nullptr;

        delete db;
        db = nullptr;
    }

    void TaskManagerTest::addTaskTest()
    {
        tm->addTask("Buy milk");

        QSqlQuery query(db->connection());
        query.exec("SELECT id, title, completed FROM tasks");

        QVERIFY(query.next());

        QCOMPARE(query.value(0).toInt(), 1);
        QCOMPARE(query.value(1).toString(), "Buy milk");
        QCOMPARE(query.value(2).toBool(), false);
    }

    void TaskManagerTest::deleteTaskTest()
    {
        QSqlQuery query(db->connection());

        tm->addTask("Buy coffee");

        query.exec("SELECT id FROM tasks");

        QVERIFY(query.next());

        int id = query.value(0).toInt();

        tm->deleteTask(id);

        query.exec("SELECT COUNT(*) FROM tasks");

        query.next();

        QCOMPARE(query.value(0).toInt(), 0);
    }

    void TaskManagerTest::searchTaskTest()
    {
        QSqlQuery query(db->connection());

        tm->addTask("Buy milk");

        query.exec("SELECT id, title, completed FROM tasks WHERE title = 'Buy milk' ");

        QVERIFY(query.next());

        QCOMPARE(query.value(1).toString(), "Buy milk");
    }

    void TaskManagerTest::updateModelTest()
    {
        QSqlQuery query(db->connection());

        tm->addTask("Buy coffee");

        query.exec("SELECT id FROM tasks");

        QVERIFY(query.next());

        int id = query.value(0).toInt();

        tm->updateModel(id, true);

        query.prepare(
            "SELECT completed FROM tasks WHERE id = :id");

        query.bindValue(":id", id);

        QVERIFY(query.exec());

        QVERIFY(query.next());

        QCOMPARE(query.value(0).toBool(), true);
    }

    void TaskManagerTest::updateTitleTest()
    {
        QSqlQuery query(db->connection());

        tm->addTask("Buy cheese");

        QVERIFY(query.exec("SELECT id FROM tasks"));

        QVERIFY(query.next());

        int id = query.value(0).toInt();

        tm->updateTitle(id, "Sell cheese");

        query.prepare(
            "SELECT title FROM tasks WHERE id = :id");

        query.bindValue(":id", id);

        QVERIFY(query.exec());

        QVERIFY(query.next());

        QCOMPARE(query.value(0).toString(), "Sell cheese");
    }

    void TaskManagerTest::clearAllTest()
    {
        QSqlQuery query(db->connection());

        tm->addTask("Buy milk");
        tm->addTask("Buy groceries");
        tm->addTask("Buy cloth");

        tm->clearAll();

        QVERIFY(query.exec(
            "SELECT COUNT(*) FROM tasks"
            ));

        QVERIFY(query.next());

        QCOMPARE(query.value(0).toInt(), 0);
    }

