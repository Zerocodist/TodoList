#pragma once

#include <QtTest>
#include "manager/taskmanager.h"
#include "database/database.h"
#include "model/listModel.h"

class TaskManagerTest : public QObject {

    Q_OBJECT

private slots:

    void init();
    void cleanup();
    void addTaskTest();
    void clearAllTest();
    void deleteTaskTest();
    void searchTaskTest();
    void updateModelTest();
    void updateTitleTest();

private:
    Database* db = nullptr;
    TaskManager* tm = nullptr;

};