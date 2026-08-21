#pragma once

#include <QObject>
#include <QSortFilterProxyModel>

class ProxyModel : public QSortFilterProxyModel {

    Q_OBJECT

public:
    explicit ProxyModel(QObject *parent = nullptr);

    Q_INVOKABLE void setSearchText(const QString &text);

protected:
    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const override;

private:
    QString m_searchText;
};
