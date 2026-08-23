#pragma once

#include <QString>
#include <QMetaType>

enum class OperationType
{
    AddTask,
    DeleteTask,
    UpdateStatus,
    UpdateTitle,
    ClearDatabase,
    LoadLogs,
    TotalTasksCount
};

struct OperationStatus
{
    OperationType operation = OperationType::AddTask;

    int id = -1;

    QString message;

    bool success = false;

    static OperationStatus fail(OperationType operation,int id = -1, const QString &message = {})
    {
        return
        {
            operation,
            id,
            message,
            false
        };
    }

    static OperationStatus ok(OperationType operation, int id = -1, const QString &message = {})
    {
        return
        {
            operation,
            id,
            message,
            true
        };
    }
};


Q_DECLARE_METATYPE(OperationStatus)