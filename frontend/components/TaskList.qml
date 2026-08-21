import QtQuick
import QtQuick.Controls

Item {
    id: root

    ListView
    {
        id: listView

        anchors.fill: parent

        cacheBuffer: 100

        boundsBehavior: Flickable.StopAtBounds

        reuseItems: true

        model: AppController ? AppController.proxyModel : null

        delegate: TaskCard {}

        clip: true

        spacing: 10

        ScrollBar.vertical:
            ScrollBar
        {
            active: true

            width: 8

            size: listView.VisualAreaHeight / Math.max(listView.contentHeight, 1)

            position: listView.contentY / Math.max(listView.contentHeight, 1)

            background: Rectangle
            {
                color: "#1F2937"
                radius: 4
            }

            contentItem:
                Rectangle
            {
                color: "#6366F1"
                radius: 4
            }

            policy: ScrollBar.AlwaysOn
        }
    }
}
