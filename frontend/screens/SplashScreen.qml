import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import TodoList

Item {
    id: root

    focus: true

    signal startClicked()

    property int titleMargin: 100

    property int subTitleMargin: 200

    property int fadeDuration: 2000

    property int subTitleDelay: 300

    property int buttonMargin: 620

    property int buttonDelay: 600

    property int titleStartMargin: 80

    property int titleEndMargin: 100

    property int subTitleStartMargin: 180

    property int subTitleEndMargin: 200

    property int buttonStartMargin: 600

    property int buttonEndMargin: 620

    property int footerDelay: 900

    property int footerStartMargin: 700

    property int footerEndMargin: 720

    AnimatedBackground
    {
        id: splashBackground
    }

    Label
    {
        id: title

        text: "Todo List"

        font.pixelSize: 40
        font.weight: Font.DemiBold

        color: "#F3F4F6"

        opacity: 0

        anchors.top: parent.top

        anchors.topMargin: root.titleMargin

        anchors.horizontalCenter: parent.horizontalCenter

        font.letterSpacing: 2

        font.capitalization: Font.AllUppercase
    }

    SequentialAnimation
    {
        running: true

        ParallelAnimation
        {
            NumberAnimation
            {
                target: title
                property: "opacity"

                from: 0
                to: 1

                duration: root.fadeDuration

                easing.type: Easing.OutCubic
            }

            NumberAnimation
            {
                target: title
                property: "anchors.topMargin"

                from: root.titleStartMargin
                to: root.titleEndMargin

                duration: root.fadeDuration

                easing.type: Easing.OutCubic
            }
        }
    }

    Label
    {
        id: logTitle

        text: "Task manager"

        opacity: 0

        color: "#aaaaaa"

        anchors.horizontalCenter: parent.horizontalCenter

        anchors.top: parent.top

        anchors.topMargin: root.subTitleMargin

        font.pixelSize: 18
    }

    SequentialAnimation
    {
        running: true

        PauseAnimation
        {
            duration: root.subTitleDelay
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                target: logTitle
                property: "opacity"

                from: 0
                to: 1

                duration: root.fadeDuration

                easing.type: Easing.OutCubic
            }

            NumberAnimation
            {
                target: logTitle
                property: "anchors.topMargin"

                from: root.subTitleStartMargin
                to: root.subTitleEndMargin

                duration: root.fadeDuration

                easing.type: Easing.OutCubic
            }
        }
    }

    ActionButton
    {
        id: startButton

        opacity: 0

        anchors.horizontalCenter: parent.horizontalCenter

        anchors.top: parent.top

        anchors.topMargin: root.buttonMargin

        buttonText: "Let's start"

        onClicked:
        {
            root.startClicked()
        }
    }

    SequentialAnimation
    {
        running: true

        PauseAnimation
        {
            duration: root.buttonDelay
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                target: startButton
                property: "opacity"

                from: 0
                to: 1

                duration: root.fadeDuration

                easing.type: Easing.OutCubic
            }

            NumberAnimation
            {
                target: startButton
                property: "anchors.topMargin"

                from: root.buttonStartMargin
                to: root.buttonEndMargin

                duration: root.fadeDuration

                easing.type: Easing.OutCubic
            }
        }
    }


    Label
    {
        id: footer

        text: "Developed by -> @zerocodist"

        anchors.top: parent.top
        anchors.topMargin: root.footerEndMargin
        anchors.horizontalCenter: parent.horizontalCenter

        opacity: 0

        color: mouse.containsMouse ? "#FFFFFF" : "#AAAAAA"
        scale: mouse.containsMouse ? 1.05 : 1.0

        Behavior on color
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
                duration: 180
            }
        }

        MouseArea
        {
            id: mouse

            anchors.fill: parent

            cursorShape: Qt.PointingHandCursor

            hoverEnabled: true

            onClicked:
            {
                Qt.openUrlExternally(
                            Qt.url("https://t.me/zerocodist")
                            )
            }
        }
    }

    SequentialAnimation
    {
        running: true

        PauseAnimation
        {
            duration: root.footerDelay
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                target: footer
                property: "opacity"

                from: 0
                to: 1

                duration: root.footerDelay

                easing.type: Easing.OutCubic
            }

            NumberAnimation
            {
                target: footer
                property: "anchors.topMargin"

                from: root.footerStartMargin
                to: root.footerEndMargin

                duration: root.fadeDuration

                easing.type: Easing.OutCubic
            }
        }
    }

}

