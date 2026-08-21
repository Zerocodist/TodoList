import QtQuick

ShaderEffect
{
    id: effect

    anchors.fill: parent

    property real time: 0

    property real speed: 0.0001

    property real wrapPeriod: 1000.0

    FrameAnimation
    {
        running: true

        onTriggered:
        {
            effect.time = (effect.time + smoothFrameTime  * effect.speed) % effect.wrapPeriod
        }
    }

    fragmentShader:
        "qrc:/local_shader/LiquiGradient.frag.qsb"
}

