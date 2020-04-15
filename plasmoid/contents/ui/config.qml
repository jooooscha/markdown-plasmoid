import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.2

Item {
    id: configPage

    property alias cfg_editor: editorText.text
    property alias cfg_filePath: filePath.text
    property alias cfg_customCSS: customCSS.text
    
    ColumnLayout {
        GridLayout {
            columns: 2
            Label {
                Layout.row: 0
                Layout.column: 0
                text: "Open file with"
            }
            TextField {
                id: editorText
                Layout.row: 0
                Layout.column: 1
                Layout.minimumWidth: 300
                placeholderText: "Editor"
            }
            Label {
                Layout.row: 1
                Layout.column: 0
                text: "Note file location"
            }
            TextField {
                id: filePath
                Layout.row: 1
                Layout.column: 1
                Layout.minimumWidth: 300
                placeholderText: "Full path"
            }
            Label {
                Layout.row: 2
                Layout.column: 0
                text: "Put some custom CSS"
            }
            TextField {
                id: customCSS
                Layout.row: 2
                Layout.column: 1
                Layout.minimumWidth: 300
                placeholderText: "h1 { color: red;}"
            }
        }
    }
}
