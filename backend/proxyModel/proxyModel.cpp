#include "../proxyModel/proxyModel.h"
#include "../model/listModel.h"

ProxyModel::ProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
    setFilterCaseSensitivity(Qt::CaseInsensitive);
}

bool ProxyModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    QModelIndex index = sourceModel()->index(sourceRow, 0, sourceParent);

    QString title = sourceModel()
        ->data(index, ListModelCpp::TitleRole).toString();

    return title.contains(m_searchText, Qt::CaseInsensitive);
}

void ProxyModel::setSearchText(const QString &text)
{
    beginFilterChange();

    m_searchText = text;

    endFilterChange();
}