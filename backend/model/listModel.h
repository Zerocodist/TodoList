#pragma once

#include <QAbstractListModel>
#include <QVector>
#include <QString>
#include "task/task.h"

class ListModelCpp : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit ListModelCpp(QObject *parent = nullptr);

    enum TaskRoles  {
        IdRole = Qt::UserRole + 1,
        TitleRole,
        CompletedRole
    };

    Q_ENUM(TaskRoles);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role) const override;

    QHash<int, QByteArray> roleNames() const override;

signals:
    void operationStatus(const QString &text);

public slots:
    void addTask(const Task &task);

    void setTasks(const QVector<Task> &tasks);

    void deleteTask(int id);

    void updateTitle(int id, const QString &title);

    void updateStatus(int id, bool completed);

    void clearAll();

private:
    QVector<Task> m_tasks;

    QHash<int, int> m_rowById;

    void rebuildIndex();
};
