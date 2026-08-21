#include "listModel.h"

ListModelCpp::ListModelCpp(QObject *parent)
    : QAbstractListModel(parent)
{

}


void  ListModelCpp::addTask(const Task &task)
{
    const int row = m_tasks.size();

    beginInsertRows(
        QModelIndex(),
        row,
        row
    );

    m_tasks.append(task);

    m_rowById.insert(task.id, row);

    endInsertRows();

    emit operationStatus("Task successfully added! ✅");
}


void ListModelCpp::setTasks(const QVector<Task> &tasks)
{
    beginResetModel();

    m_tasks = tasks;

    m_rowById.clear();

    rebuildIndex();

    endResetModel();
}

void ListModelCpp::deleteTask(int id)
{
    auto it = m_rowById.find(id);

    if(it == m_rowById.end())
        return;

    const int row = it.value();

    beginRemoveRows(
        QModelIndex(),
        row,
        row
    );

    m_tasks.removeAt(row);

    endRemoveRows();

    emit operationStatus("Task successfully deleted! ✅");

    rebuildIndex();
}


void ListModelCpp::rebuildIndex()
{
    m_rowById.clear();

    for(int row = 0; row < m_tasks.size(); ++row)
    {
        m_rowById.insert(m_tasks[row].id, row);
    }
}


int ListModelCpp::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);

    return m_tasks.size();
}

QVariant ListModelCpp::data(const QModelIndex &index, int role) const
{
    const Task &task =
        m_tasks.at(index.row());

    switch(role)
    {
    case IdRole:
        return task.id;
    case TitleRole:
        return task.title;
    case CompletedRole:
        return task.completed;
    }

    return QVariant();
}

QHash<int, QByteArray> ListModelCpp::roleNames() const
{
    return {
        {IdRole, "id"},
        {TitleRole, "title"},
        {CompletedRole, "completed"}
    };
}

void ListModelCpp::updateTitle(int id, const QString &title)
{
    auto it = m_rowById.find(id);

    if(it == m_rowById.end())
        return;

    const int row = it.value();

    m_tasks[row].title = title;

    const QModelIndex idx = index(row);

    emit dataChanged(
        idx,
        idx,
        {TitleRole}
    );
}

void ListModelCpp::updateStatus(int id, bool completed)
{
    auto it = m_rowById.find(id);

    if(it == m_rowById.end())
        return;

    const int row = it.value();

    m_tasks[row].completed = completed;

    const QModelIndex idx = index(row);

    emit dataChanged(
        idx,
        idx,
        {CompletedRole}
    );
}

void ListModelCpp::clearAll()
{
    beginResetModel();

    m_tasks.clear();

    m_rowById.clear();

    endResetModel();

    emit operationStatus("All tasks successfully cleared! ✅");
}

