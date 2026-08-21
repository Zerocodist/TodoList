import QtQuick
import QtQuick.Controls

Row
{
    id: root

    property bool checkedState: false

    property string boxText: ""

    signal toggled(bool checked)

    spacing: 10

    Rectangle
    {
        width: 24
        height: 24
        radius: 6

        border.width: 2

        color: root.checkedState ? Qt.rgba(0.15, 0.25, 0.4, 0.45) : "transparent"

        scale: 1

        border.color: "white"

        Text
        {
            anchors.centerIn: parent
            text: "✓"
            color: "#D5D8E0"

            opacity: root.checkedState ? 1 : 0
            scale: root.checkedState ? 1 : 0.5

            Behavior on opacity
            {
                NumberAnimation
                {
                    duration: 150
                }
            }

            Behavior on scale
            {
                NumberAnimation
                {
                    duration: 150
                }
            }
        }

        MouseArea
        {
            anchors.fill: parent

            onClicked:
            {
                root.checkedState = !root.checkedState
                root.toggled(checkedState)
            }
        }
    }

    Label
    {
        text: boxText
        font.pixelSize: 20
        font.weight: Font.DemiBold
        color: "#D5D8E0"
    }

}
