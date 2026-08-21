import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import TodoList

Item {

        AnimatedBackground
        {
                id: animatedBackground
        }

        ColumnLayout {
                anchors.fill: parent

                anchors.topMargin: 100
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                anchors.bottomMargin: 20

                spacing: 20

                TaskInput {
                        id: input
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                }

                SearchField
                {
                        id: searchField

                        Layout.alignment: Qt.AlignHCenter
                }

                Rectangle
                {
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        radius: 16

                        color: "#30343E"

                        TaskList

                        {
                                anchors.fill: parent
                                id: taskList
                        }
                }

                Row
                {
                        spacing: 10

                        ActionButton
                        {
                                buttonText: "Clear all"

                                buttonWidth: 150
                                buttonHeight: 60

                                onClicked: AppController.clearModel();
                        }

                        ActionButton
                        {
                                buttonText: "Clear Database"

                                buttonWidth: 150
                                buttonHeight: 60

                                onClicked: AppController.clearDatabase()
                        }

                        ActionButton
                        {
                                buttonText: "Load logs"

                                buttonWidth: 150
                                buttonHeight: 60

                                onClicked: AppController.loadLogs()
                        }

                        PaginationPanel
                        {
                                id: paginationPanel
                        }

                        Rectangle
                        {
                                width: 150
                                height: 65

                                color: "#30343E"

                                radius: 8

                                Column
                                {
                                        anchors.margins: 5

                                        spacing: 5

                                        anchors.centerIn: parent

                                        CustomCheckbox
                                        {
                                                id: search

                                                boxText: "Search"

                                                onCheckedStateChanged:
                                                {
                                                        searchField.showIf(checkedState)
                                                }
                                        }

                                        CustomCheckbox
                                        {
                                                id: pagination

                                                boxText: "Pagination"

                                                onCheckedStateChanged:
                                                {
                                                        paginationPanel.showIf(checkedState)
                                                }
                                        }
                                }
                        }
                }
        }

        Notification
        {
                id: notification

                anchors.horizontalCenter: parent.horizontalCenter

                anchors.top: parent.top

                anchors.topMargin: 30
        }

}