import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import QtWebKit  3.0
import QtWebView 1.14
import QtWebEngine 1.10

import "functions.js" as Func
import "markdown-it.js" as Markit

Item {
    width: 800
    height: 600

    property string editor: Plasmoid.configuration.editor
    property string filePath: Plasmoid.configuration.filePath
    property string customCSS: Plasmoid.configuration.customCSS

    PlasmaCore.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: {
            var exitCode = data["exit code"]
            var exitStatus = data["exit status"]
            var stdout = data["stdout"]
            var stderr = data["stderr"]
            exited(sourceName, exitCode, exitStatus, stdout, stderr)
            disconnectSource(sourceName) // cmd finished
        }
        function exec(cmd) {
            if (cmd) {
                connectSource(cmd)
            }
        }
        signal exited(string cmd, int exitCode, int exitStatus, string stdout, string stderr)
    }

    function loadfile() {
        Func.loadfile(filePath, customCSS)
    }

    ScrollView {
        Text {
            id: viewtext
            color: "#DDDDDD"
            textFormat: Text.RichText
        }

        id: scrollview
        width: parent.width
        anchors.top: parent.top
        anchors.bottom: reload.top
        anchors.bottomMargin: 10
        Component.onCompleted: loadfile()
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        anchors.rightMargin: 30
        onClicked: {
            executable.exec(editor + " " + filePath)
        }
    }


    Text {
        id: lockedSign
        color: "#DDDDDD"
        visible: false
        text: "Note hidden"
        anchors.centerIn: parent
        font.pointSize: 50
        font.bold: true
    }

    Button {
        id: hideButton
        text: "Hide Note"
        anchors.bottom: parent.bottom
        width: 80
        height: 40
        focusPolicy: "NoFocus"
        onClicked: {
            Func.hideText(filePath, customCSS)
        }
    }

    Button {
        id: reload
        text: "Reload"
        anchors.bottom: parent.bottom
        anchors.left: hideButton.right
        width: 80
        height: 40
        focusPolicy: "NoFocus"
        onClicked: { loadfile() }
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: { loadfile() }
    }
}
