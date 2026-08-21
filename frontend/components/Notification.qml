import QtQuick
import QtQuick.Controls

Item
{
    id: toast

    property int toastDuration: 700

    opacity: 0

    scale: 0.95

    z: 100

    anchors.horizontalCenter: parent.horizontalCenter

    width: textItem.implicitWidth + 20
    height: textItem.implicitHeight + 10

    property string message: ""

    Text
    {
        id: textItem

        text: toast.message

        color: "white"

        font.bold: true

        anchors.centerIn: parent

        width: Math.min(implicitWidth + 20, 500)

        wrapMode: Text.WordWrap

        maximumLineCount: 2

        elide: Text.ElideRight

        font.pixelSize: 20
    }

    Connections
    {
        target: AppController

        function onOperationStatus(message)
        {
            toast.message = message
            toast.opacity = 0
            toast.scale = 0.9

            showAnimation.stop()
            showAnimation.restart()
        }
    }

    SequentialAnimation
    {
        id: showAnimation

        running: false

        ParallelAnimation
        {
            NumberAnimation
            {
                target: toast

                property: "opacity"

                from: 0
                to: 1

                duration: 350

                easing.type: Easing.OutBack
            }

            NumberAnimation
            {
                target: toast

                property: "scale"

                from: 0.9
                to: 1

                duration: 350

                easing.type: Easing.OutBack
            }
        }

        PauseAnimation
        {
            duration: toastDuration
        }

        ParallelAnimation
        {
            id: hideAnimation

            NumberAnimation
            {
                target: toast

                property: "opacity"

                from: 1
                to: 0

                duration: 350

                easing.type: Easing.InBack
            }

            NumberAnimation
            {
                target: toast

                property: "scale"

                from: 1
                to: 0.9

                duration: 350

                easing.type: Easing.InBack
            }
        }
    }
}




