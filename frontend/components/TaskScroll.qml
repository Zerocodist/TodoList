import QtQuick
import QtQuick.Controls

Item {

    id: main

    property int backButtonHeight: 30

    property int soonButtonHeight: 30

    visible: false

    function showIf(value)
    {
        if(value && !visible)
        {
            main.visible = true

            pageScroll.opacity = 0

            pageScroll.scale = 0.9

            showAnimation.restart()
        }

        else if(!value && visible)
        {
            hideAnimation.start()
        }
    }

    Row
    {
        id: pageScroll

        anchors.centerIn: parent

        opacity: 0

        scale: 0.9

        spacing: 5

        ActionButton
        {
            buttonText: "🔙"

            buttonHeight: backButtonHeight

            enabled: AppController && AppController .currentPage > 1

            onClicked: AppController.previousPage()

            anchors.verticalCenter: parent.verticalCenter
        }

        Label
        {
            text:  `Page ${AppController?.currentPage ?? 0}/${AppController?.totalPages ?? 0}`

            anchors.verticalCenter: parent.verticalCenter

            color: "#D5D8E0"

            font.weight: Font.DemiBold

            font.pixelSize: 30
        }

        ActionButton
        {
            buttonText: "🔜"

            buttonHeight: soonButtonHeight

            enabled: AppController && AppController.currentPage < AppController.totalPages

            onClicked: AppController.nextPage()

            anchors.verticalCenter: parent.verticalCenter
        }

    }

    ParallelAnimation
    {
        id: showAnimation

        running: false

        NumberAnimation
        {
            target: pageScroll

            property: "opacity"

            from: 0
            to: 1

            duration: 250

            easing.type: Easing.OutCubic
        }

        NumberAnimation
        {
            target: pageScroll

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
                target: pageScroll

                property: "opacity"

                from: 1
                to: 0

                duration: 250

                easing.type: Easing.InOutCubic
            }

            NumberAnimation
            {
                target: pageScroll

                property: "scale"

                from: 1
                to: 0.9

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
