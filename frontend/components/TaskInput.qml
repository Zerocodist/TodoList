import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
id: root

    property alias text: taskField.text

    property bool inputFocus: taskField.activeFocus

    signal taskSumbitted(string text)

    function sumbitTask()
    {
       const value = taskField.text.trim()

        if(value.length === 0)
            return

        taskSumbitted(value)
        taskField.clear()
    }

    TextField {
        id: taskField

        placeholderText: "Enter task..."
        placeholderTextColor: "#888888"

        Layout.preferredHeight: 60
        Layout.fillWidth: true

        color: "black"

        font.bold: true
        font.pixelSize: 18

        horizontalAlignment: TextInput.AlignLeft
        verticalAlignment: TextInput.AlignVCenter

        background: Rectangle
        {
            radius: 15
            border.color: root.inputFocus ? "black" : "#555555"
            border.width: 3
        }

        cursorDelegate: Rectangle
        {
            width: 2
            color: "black"
        }

        onAccepted:
        {
            root.sumbitTask()
        }
    }

    ActionButton {
        buttonText: "add"

        onClicked: root.sumbitTask()
    }

    onTaskSumbitted: function(text)
    {
        AppController.addTask(text)
    }
}

