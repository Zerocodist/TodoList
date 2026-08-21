#include "../database/databaseTest.h"

void DatabaseTest::init()
{
    db = new Database(DatabaseMode::Test);
}

void DatabaseTest::cleanup()
{
    delete db;
    db = nullptr;
}

void DatabaseTest::dbConnectTest()
{
    QSqlQuery query(db->connection());

    QVERIFY(db->connection().isValid());
    QVERIFY(db->connection().isOpen());

}

void DatabaseTest::tableExistTest()
{
    QSqlQuery query(db->connection());

    QVERIFY(query.exec(
        "SELECT name "
        "FROM sqlite_master "
        "WHERE type='table' "
        "AND name='tasks'"
        ));

    QVERIFY(query.next());
}
