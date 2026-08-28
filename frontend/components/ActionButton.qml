import QtQuick
import QtQuick.Controls

Item
{
    id: root

    width: buttonWidth
    height: buttonHeight

    property int buttonWidth: 160

    property int buttonHeight: 70

    property int buttonRadius: 18

    property string buttonText: "export"

    property bool pressed: mouseArea.pressed

    property bool hovered: mouseArea.containsMouse

    signal clicked()

    Rectangle
    {
        id: button

        anchors.fill: parent

        color: root.pressed
               ? "#22252D"
               : root.hovered
                 ? "#30343E"
                 : "#2A2D35"

        opacity: root.hovered ? 1.0 : 0.9

        scale: root.pressed ? 0.95 : root.hovered ? 1.03 : 1.0

        border.color: root.hovered
        ? "#555A66"
        : "#3B3F49"

        border.width: 1

        radius: buttonRadius

        Behavior on color
        {
            ColorAnimation
            {
                duration: 180
            }
        }

        Behavior on border.color
        {
            ColorAnimation
            {
                duration: 180
            }
        }

        Behavior on scale
        {
            NumberAnimation
            {
                duration: 120
                easing.type: Easing.OutCubic
            }
        }

        Behavior on opacity
        {
            NumberAnimation
            {
                duration: 120
            }
        }

        Text
        {
            anchors.centerIn: parent

            text: root.buttonText

            font.pixelSize: 20
            font.weight: Font.Medium

            color: root.hovered
            ? "#F1F3F7"
            : "#D5D8E0"

            Behavior on color
            {
                ColorAnimation
                {
                    duration: 180
                }
            }
        }

        MouseArea
        {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: root.clicked()
        }
    }
}