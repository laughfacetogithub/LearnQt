// 2018051604079 Xiang Jiewen
import QtQuick 2.2
import QtQuick.Controls 1.4 //To use TextArea, it must be this version1.4
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import FilesIO 1.0


ApplicationWindow {
    id: root
    visible: true
    width: 640; height: 480
    title: qsTr("Untitled-")+qsTr("Notepad")

    property string currentfile
    minimumWidth: 400
    minimumHeight: 300

    property string bkcolor: "white"
    property string textscolor: "black"


    Action {
        id: newAction
        text: qsTr("&New")
        shortcut: "ctrl+n"
        onTriggered: {
            textarea.text = "";
        }
    }

    Action {
        id: openAction
        text: qsTr("&Open")
        shortcut: "ctrl+o"
        onTriggered: {
            openFileDialog.open()
        }

    }

    Action {
        id: saveAction
        text: qsTr("&Save")
        shortcut: "ctrl+s"
        onTriggered: {
            filesio.save(textarea.text, currentfile)

        }
    }

//    Action {
//        id: saveASAction
//        text: qsTr("S&ave as")
//        onTriggered: saveAsDialog.open()
//    }



    Action {
        id: undoAction
        text: qsTr("Undo")
        shortcut: "ctrl+z"
    }

    Action {
        id: copyAction
        text: qsTr("Copy")
        shortcut: "ctrl+c"
    }

    Action {
        id: pasteAction
        text: qsTr("Paste")
        shortcut: "ctrl+p"
    }

    Action {
        id: cutAction
        text: qsTr("Cut")
        shortcut: "ctrl+x"
    }

    Action {
        id: aboutAction
        text: qsTr("About")
        onTriggered: {
            aboutDialog.open()
        }
    }

    Action {
        id: darkThemeAction
        text: qsTr("Dark")
        onTriggered: {
            bkcolor = "darkslategray"
            textscolor = "ghostwhite"
        }
    }

    Action {
        id: whiteyThemeAction
        text: qsTr("Whitey")
        onTriggered: {
            bkcolor = "white"
            textscolor = "black"
        }
    }


    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {action: newAction}
            MenuSeparator{}
            MenuItem {action: openAction}
            MenuItem {action: saveAction}
            //MenuItem {action: saveASAction}


        }

        Menu {
            title: qsTr("&Edit")
            MenuItem {action: undoAction}
            MenuSeparator{}
            MenuItem {action: cutAction}
            MenuItem {action: copyAction}
            MenuItem {action: pasteAction}


        }

        Menu {
            title: qsTr("&Themes")
            MenuItem {action: darkThemeAction}
            MenuItem {action: whiteyThemeAction}
        }

        Menu {
            title: qsTr("&Help")
            MenuItem {action: aboutAction}
        }

    }



    property var nametype: [
        "All files (*.*)",
        "Text files (*.txt)", "HTML files (*.html, *.htm)",
        "C files (*.c)", "C++ files (*.cpp, *.cc)",
        "JS files (*js)", "JSON files (*.json)", "Java files (*.java)",
        "Python files (*py)", "QML files (*.qml)", "XML files (*.xml)"
                           ]

    FileDialog {
        id: openFileDialog
        title: "Choose a file! man!"
        nameFilters: nametype
        onAccepted: {
            textarea.text = filesio.open(openFileDialog.fileUrl)
            currentfile = openFileDialog.fileUrl

        }
    }

    FileDialog {
        id: saveAsDialog
        title: "Choose a file~~~~"
        nameFilters: nametype
        onAccepted: {
            filesio.save(textarea.text, saveFileDialog.fileUrl)
            currentfile = openFileDialog.fileUrl
        }

    }


    MessageDialog {
        id: aboutDialog
        title: "About Notepad"
        text: "A boring notepad application"
        icon: StandardIcon.Information
    }


    TextArea {

        id: textarea
        anchors.fill: parent
        style: TextAreaStyle {
            id: textareastyle

            textColor: textscolor
            selectionColor: "steelblue"
            selectedTextColor: "#eee"
            backgroundColor: bkcolor
            font.pointSize: 16
        }


        textFormat: TextEdit.AutoText
        wrapMode: TextEdit.Wrap

    }



    FilesIO {
        id: filesio
    }
}
