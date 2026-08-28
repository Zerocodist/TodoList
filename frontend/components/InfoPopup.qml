import QtQuick
import QtQuick.Controls

Item {

    id: main

    anchors.fill: parent

    visible: false

    property int infoPopupWidth: 500

    property int infoPopupHeight: 150

    property string infoPopupText: ""


    function showPopup()
    {
        main.visible = true

        infoPopup.opacity = 0

        infoPopup.scale = 0.9

        overlay.opacity = 0

        showAnimation.restart()
    }

    function hidePopup()
    {
        hideAnimation.start()
    }

    Rectangle
    {
        id: overlay

        anchors.fill: parent

        color: "black"

        opacity: 0

        z: 1

        MouseArea
        {
            anchors.fill: parent

            onClicked:
            {
                hidePopup()
            }
        }

    }


    Rectangle
    {
        id: infoPopup

        width: Math.min(label.implicitWidth + 60, infoPopupWidth)
        height: label.implicitHeight + 80

        anchors.centerIn: parent

        radius: 8

        z: 2

        opacity: 0

        scale: 0.9

        color: "#2A2D35"

        border.color: "#3B3F49"

        border.width: 1

        MouseArea
        {
            anchors.fill: parent

            onClicked:
            {
                mouse.accepted = true
            }
        }

        ToolButton
        {
            id: toolButton

            text: "X"

            anchors.right: parent.right
            anchors.top: parent.top

            hoverEnabled: true

            opacity: hovered ? 0.9 : 1

            scale: pressed ? 0.95 : hovered ? 1.50 : 1.0

            anchors.rightMargin: 5
            anchors.topMargin: 5

            background: Rectangle
            {
                color: "transparent"
            }

            contentItem: Text
            {
               text: toolButton.text
               font: toolButton.font

               horizontalAlignment: Text.AlignHCenter
               verticalAlignment: Text.AlignVCenter

               color: toolButton.hovered ? "#F1F3F7" : "#D5D8E0"

               Behavior on color
               {
                   ColorAnimation
                   {
                       duration: 180
                   }
               }
            }

            onClicked:
            {
                hidePopup()
            }

            Behavior on scale
            {
                NumberAnimation
                {
                    duration: 180
                }
            }

            Behavior on opacity
            {
                NumberAnimation
                {
                    duration: 180
                }
            }
        }

        Label
        {
            id: label

            text: infoPopupText

            anchors.centerIn: parent

            font.weight: Font.DemiBold
            font.pixelSize: 20

            width: parent.width - 60

            wrapMode: Text.Wrap

            horizontalAlignment: Text.AlignHCenter

            color: "#F1F3F7"
        }
    }


    ParallelAnimation
    {
        id: showAnimation

        NumberAnimation
        {
            target: infoPopup

            property: "opacity"

            from: 0
            to: 1

            duration: 250

            easing.type: Easing.OutCubic
        }

        NumberAnimation
        {
            target: infoPopup

            property: "scale"

            from: 0.9
            to: 1

            duration: 250

            easing.type: Easing.OutCubic
        }

        NumberAnimation
        {
            target: overlay

            property: "opacity"

            from: 0
            to: 0.5

            duration: 250

            easing.type: Easing.OutCubic
        }
    }

    SequentialAnimation
    {
        id: hideAnimation

        ParallelAnimation
        {
            NumberAnimation
            {
                target: infoPopup

                property: "opacity"

                from: 1
                to: 0

                duration: 250

                easing.type: Easing.InOutCubic
            }

            NumberAnimation
            {
                target: infoPopup

                property: "scale"

                from: 1
                to: 0.9

                duration: 250

                easing.type: Easing.InOutCubic
            }

            NumberAnimation
            {
                target: overlay

                property: "opacity"

                from: 0.5
                to: 0

                duration: 250

                easing.type: Easing.InOutCubic
            }
        }

        ScriptAction
        {
            script: main.visible = false
        }
    }
}
