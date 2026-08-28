import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {

    id: main

    property string exitPopupText: "Are you sure, you want to close app ?⚠"

    property int exitPopupWidth: 300

    property int exitPopupHeight: 100

    signal exitSuccess()

    anchors.fill: parent

    visible: false

    function showPopup()
    {
        main.visible = true

        exitPopup.opacity = 0

        exitPopup.scale = 0.9

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

        opacity: 0

        color: "black"

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
        id: exitPopup

        width: Math.min(label.implicitWidth + 60, exitPopupWidth)
        height: Math.max(label.implicitHeight + 80, 180)

        anchors.centerIn: parent

        scale: 0.9

        opacity: 0

        border.color: "#3B3F49"

        border.width: 1

        color: "#2A2D35"

        radius: 8

        z: 2


        MouseArea
        {
            anchors.fill: parent

            onClicked:
            {
                mouse.accepted = true
            }
        }

        ColumnLayout
        {
            id: contentColumn

            width: parent.width - 40

            anchors.centerIn: parent

            spacing: 20

            Label
            {
                id: label

                text: exitPopupText

                Layout.fillWidth: true

                wrapMode: Text.Wrap

                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: 20
                font.weight: Font.DemiBold

                color: "#F1F3F7"
            }

            Row
            {
                Layout.alignment: Qt.AlignHCenter

                spacing: 10

                ActionButton
                {
                    buttonText: "Yes"

                    buttonWidth: 80
                    buttonHeight: 50

                    buttonRadius: 3

                    onClicked:
                    {
                        exitSuccess()

                        hidePopup()
                    }
                }

                ActionButton
                {
                    buttonText: "No"

                    buttonWidth: 80
                    buttonHeight: 50

                    buttonRadius: 3

                    onClicked:
                    {
                        hidePopup()
                    }
                }
            }
        }
    }

    ParallelAnimation
    {
        id: showAnimation

        NumberAnimation
        {
            target: exitPopup

            property: "opacity"

            from: 0
            to: 1

            duration: 250

            easing.type: Easing.OutCubic
        }

        NumberAnimation
        {
            target: exitPopup

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
                target: exitPopup

                property: "opacity"

                from: 1
                to: 0

                duration: 250

                easing.type: Easing.InOutCubic
            }

            NumberAnimation
            {
                target: exitPopup

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
            script:
            {
                main.visible = false
            }
        }
    }
}
