import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import TodoList

Item {
        id: main

        signal exitAccepted()



        function showExitPopup()
        {
                exitPopup.showPopup()
        }

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

                TaskScroll
                {
                        id: taskScroll

                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 30
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

                                onClicked:
                                {
                                        confirmPopup.showPopup()
                                }
                        }

                        ActionButton
                        {
                                buttonText: "Load logs"

                                buttonWidth: 150
                                buttonHeight: 60

                                onClicked:
                                {
                                        if(pagination.checkedState)
                                        {
                                                if(paginationPanel.limitField.trim() === "")
                                                {
                                                        return
                                                }

                                                AppController.loadTasksByPage(
                                                                        Number(paginationPanel.offsetField),
                                                                        Number(paginationPanel.limitField)
                                                )
                                        }

                                        else
                                        {
                                                AppController.loadTasks()
                                        }
                                }
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
                                                        taskScroll.showIf(checkedState)
                                                }
                                        }
                                }
                        }
                }
        }

        CustomDrawer
        {
                id: drawer

                anchors.left: parent.left
                anchors.top: parent.top

                anchors.topMargin: 10
                anchors.leftMargin: 10
        }

        Notification
        {
                id: notification

                anchors.horizontalCenter: parent.horizontalCenter

                anchors.top: parent.top

                anchors.topMargin: 30
        }

        ConfirmPopup
        {
                id: confirmPopup
        }

        ExitPopup
        {
                id: exitPopup

                onExitSuccess:
                {
                        main.exitAccepted()
                }
        }
}