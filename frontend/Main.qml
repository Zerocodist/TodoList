import QtQuick
import QtQuick.Controls
import QtQuick.Window
import TodoList

ApplicationWindow
{
    id: mainWindow

    property int fadeDuration: 500

    property int closeDuration: 350

    property int windowMinimumWidth: 1000

    property int windowMinimumHeight: 700

    property bool exitConfirmed: false

    onClosing: function(close)
    {
        if(exitConfirmed)
        {
            close.accepted = true

            return
        }

        close.accepted = false

        if(stack.currentItem &&
                typeof stack.currentItem.showExitPopup === "function")
        {
            stack.currentItem.showExitPopup()
        }
        else
        {
            closeAnimation.start()
        }
    }

    Component
    {
        id: splashScreenComponent
        SplashScreen {}
    }

    Component
    {
        id: mainScreenComponent
        MainScreen {}
    }

    width: Screen.width * 0.7
    height: Screen.height * 0.7

    minimumWidth: mainWindow.windowMinimumWidth
    minimumHeight: mainWindow.windowMinimumHeight

    visible: true

    title: "Async Log Analyzer"

    StackView
    {
        id: stack

        anchors.fill: parent

        initialItem: splashScreenComponent

        focus: true

        pushEnter: Transition {}
        pushExit: Transition {}
    }

    Rectangle
    {
        id: fadeRect

        color: "black"

        opacity: 0

        anchors.fill: parent

        z: 100
    }

    SequentialAnimation
    {
        id: screenTransition

        NumberAnimation
        {
            target: fadeRect

            property: "opacity"

            from: 0
            to: 1

            duration: mainWindow.fadeDuration

            easing.type: Easing.InOutQuad
        }

        ScriptAction
        {
            script:
            {
                stack.push(mainScreenComponent)
            }
        }

        NumberAnimation
        {
            target: fadeRect

            property: "opacity"

            from: 1
            to: 0

            duration: mainWindow.fadeDuration

            easing.type: Easing.InCubic
        }
    }

    Connections
    {
        target: stack.currentItem

        ignoreUnknownSignals: true

        function onStartClicked()
        {
            screenTransition.start()
        }

        function onExitAccepted()
        {
            closeAnimation.start()
        }
    }

    SequentialAnimation
    {
        id: closeAnimation

        NumberAnimation
        {
            target: mainWindow

            property: "opacity"

            from: 1
            to: 0

            duration: mainWindow.closeDuration

            easing.type: Easing.InOutQuad
        }

        ScriptAction
        {
            script:
            {
                mainWindow.exitConfirmed = true
                Qt.quit()
            }
        }
    }
}




