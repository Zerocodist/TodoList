#pragma once

#include <QString>
#include <QMetaType>

struct Task {
    int id;
    QString title;
    bool completed;
};

Q_DECLARE_METATYPE(Task)