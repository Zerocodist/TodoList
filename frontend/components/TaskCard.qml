import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {

    id: root

    property bool editing: false

    width: ListView.view ? ListView.view.width : 0
    height: 60

    radius: 12

    color: "#2c2c2c"

    RowLayout {
        anchors.fill: parent
        anchors.margins: 15

        spacing: 10

        CustomCheckbox
        {
            id: customCheckbox
        }

        Label {
            visible: !root.editing

            text: model.title

            color: "white"

            font.weight: Font.DemiBold
            font.bold: true
            font.pixelSize: 24

            width: parent.width
            height: contentHeight

            MouseArea {
                anchors.fill: parent
                onDoubleClicked: root.editing = true
            }
        }

        TextField {
            width: parent.width
            height: 36
            visible: root.editing
            text: model.title
            focus: root.editing
            opacity: visible ? 1 : 0

            Behavior on opacity {
                NumberAnimation
                {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }

            onAccepted: {
                AppController.updateTitle(model.id, text)
                root.editing = false
            }

            onActiveFocusChanged: {
                if(!activeFocus && root.editing) {
                    AppController.updateTitle(model.id, text)
                    root.editing = false
                }
            }

            onEditingFinished: {
                root.editing = false
            }
        }

        ActionButton {
            buttonText: "Delete"
            implicitHeight: 36
            Layout.alignment: Qt.AlignRight
            onClicked: AppController.deleteTask(model.id)
        }
    }
}

