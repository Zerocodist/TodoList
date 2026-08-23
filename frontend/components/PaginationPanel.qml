import QtQuick
import QtQuick.Controls

Item {

    id: main

    visible: false

    property int paginationWidth: 250
    property int paginationHeight: 55

    property int offsetFieldWidth: 50
    property int offsetFieldHeight: 35

    property int limitFieldWidth: 50
    property int limitFieldHeight: 35

    property alias offsetField: offset.text
    property alias limitField: limit.text


    function showIf(value)
    {
        if(value)
        {
            main.visible = true

            paginationPanel.opacity = 0

            paginationPanel.scale = 0.9

            showAnimation.restart()
        }

        else
        {
            hideAnimation.start()
        }
    }

    width: paginationWidth
    height: paginationHeight

    Rectangle
    {
        id: paginationPanel

        anchors.fill: parent

        radius: 8

        opacity: 0

        scale: 0.9

        color: "#2A2D35"

        border.color: "#3B3F49"

        border.width: 1


        Row
        {
            anchors.margins: 5

            spacing: 5

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Label
            {
                text: "Offset"
                color: "#D5D8E0"
                font.bold: true
                font.weight: Font.DemiBold
                font.pixelSize: 18

                anchors.verticalCenter: parent.verticalCenter
            }

            TextField
            {
                id: offset

                width: offsetFieldWidth
                height: offsetFieldHeight

                color: "black"

                placeholderText: "0"
                placeholderTextColor: "#888888"

                font.pixelSize: 18
                font.bold: true

                background: Rectangle
                {
                    radius: 8
                    color: "white"
                }
            }

            Label
            {
                text: "Limit"
                color: "#D5D8E0"
                font.bold: true
                font.weight: Font.DemiBold
                font.pixelSize: 18

                anchors.verticalCenter: parent.verticalCenter
            }

            TextField
            {
                id:limit

                width: limitFieldWidth
                height: limitFieldHeight

                color: "black"

                placeholderText: "20"
                placeholderTextColor: "#888888"

                font.pixelSize: 18
                font.bold: true

                background: Rectangle
                {
                    radius: 8
                    color: "white"
                }
            }
        }
    }

    ParallelAnimation
    {
        id: showAnimation

        running: false

        NumberAnimation
        {
            target: paginationPanel

            property: "opacity"

            from: 0
            to: 1

            duration: 250

            easing.type: Easing.OutCubic
        }

        NumberAnimation
        {
            target: paginationPanel

            property: "scale"

            from: 0.9
            to: 1

            duration: 250

            easing.type: Easing.OutCubic
        }
    }

    SequentialAnimation
    {
        id: hideAnimation

        ParallelAnimation
        {
            running: false

            NumberAnimation
            {
                target: paginationPanel

                property: "opacity"

                from: 1
                to: 0

                duration: 250

                easing.type: Easing.InOutCubic
            }

            NumberAnimation
            {
                target: paginationPanel

                property: "scale"

                from: 1
                to: 0.9

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
