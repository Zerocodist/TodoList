import QtQuick
import QtQuick.Controls

Item {
    id: main

    visible: false

    property int  searchHeight: 40

    property int searchWidth: 300

    width: searchWidth
    height: searchHeight

    function showIf(value)
    {
        if(value)
        {
            main.visible = true

            searchField.opacity = 0

            searchField.scale = 0.9

            showAnimation.restart()
        }

        else
        {
            hide()
        }
    }

    function hide()
    {
        searchField.text = ""

        hideAnimation.restart()
    }

    TextField
    {
        id: searchField

        anchors.fill: parent

        opacity: 0

        color: "#202124"

        placeholderText: "search..."
        placeholderTextColor: "#888888"

        font.weight: Font.DemiBold

        font.bold: true

        font.pixelSize: 24

        background: Rectangle
        {
            radius: 8

            color: "white"

            border.color: "black"

            border.width: 1
        }

        onTextChanged:
        {
            AppController.search(searchField.text)
        }
    }

    ParallelAnimation
    {
        id: showAnimation

        running: false

        NumberAnimation
        {
            target: searchField

            property: "opacity"

            from: 0
            to: 1

            duration: 250

            easing.type: Easing.OutCubic
        }

        NumberAnimation
        {
            target: searchField

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
                target: searchField

                property: "opacity"

                from: 1
                to: 0

                duration: 250

                easing.type: Easing.InOutCubic
            }

            NumberAnimation
            {
                target: searchField

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
