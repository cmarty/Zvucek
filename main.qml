/*
  Zvucek

  Copyright (c) Martin Farník

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0.txt

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/


import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtMultimedia 5.7
import Qt.labs.settings 1.0

ApplicationWindow {
    id: appWindow
    visible: true
    width: 410
    height: 680
    title: "Zvuček"
    property bool isLandscape: width > height
    //Material.theme : Material.Dark
    // font sizes - defaults from Google Material Design Guide
    property int fontSizeDisplay4: 112
    property int fontSizeDisplay3: 56
    property int fontSizeDisplay2: 45
    property int fontSizeDisplay1: 34
    property int fontSizeHeadline: 24
    property int fontSizeTitle: 20
    property int fontSizeSubheading: 16
    property int fontSizeBodyAndButton: 14 // is Default
    property int fontSizeCaption: 12

    Settings {
        id: settings
        property alias toneName: toneText.text
        property string toneSource: playSound.source

        Component.onCompleted: {
            playSound.source = toneSource
        }
    }

    header: ToolBar {
        id: toolbar
        RowLayout {
            anchors.fill: parent
            Label {
                //Layout.fillWidth: true
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Zvuček"
                //horizontalAlignment: Qt.AlignHCenter
                //verticalAlignment: Qt.AlignVCenter
                font.pixelSize: fontSizeTitle
            }    

            ToolButton {
                id: optionButton
                anchors.right: parent.right
                visible: true
                focusPolicy: Qt.NoFocus
                Image {
                    anchors.centerIn: parent
                    source: "qrc:/images/white/more_vert.png"
                }
                onClicked: {
                    optionsMenu.open()
                }
                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight
                    MenuItem {
                        text: "O aplikaci"
                        onTriggered: aboutDialog.open()
                    }
                    onAboutToHide: {
                        appWindow.resetFocus()
                    }
                } // end optionsMenu
            } // end ToolButton
        }
    }

    ColumnLayout {
        //Layout.fillWidth: true
        //anchors.horizontalCenter: parent
        anchors.left: parent.left
        anchors.right: parent.right
        Button {            
            //anchors.horizontalCenter: parent.
            //anchors.centerIn: parent
            Layout.alignment: Qt.AlignHCenter

            text: "Ton:"
            onClicked: toneMenu.open()
            Menu {
                id: toneMenu
                MenuItem { text: "C1 262Hz"; onClicked: { playSound.source = "qrc:/sounds/C1_262Hz.wav"; toneText.text = text } }
                MenuItem { text: "D1 294Hz"; onClicked: { playSound.source = "qrc:/sounds/D1_294Hz.wav"; toneText.text = text } }
                MenuItem { text: "E1 330Hz"; onClicked: { playSound.source = "qrc:/sounds/E1_330Hz.wav"; toneText.text = text } }
                MenuItem { text: "F1 349Hz"; onClicked: { playSound.source = "qrc:/sounds/F1_349Hz.wav"; toneText.text = text } }
                MenuItem { text: "G1 392Hz"; onClicked: { playSound.source = "qrc:/sounds/G1_392Hz.wav"; toneText.text = text } }
                MenuItem { text: "A1 440Hz"; onClicked: { playSound.source = "qrc:/sounds/A1_440Hz.wav"; toneText.text = text } }
                MenuItem { text: "B1 494Hz"; onClicked: { playSound.source = "qrc:/sounds/B1_494Hz.wav"; toneText.text = text } }
                MenuItem { text: "C2 523Hz"; onClicked: { playSound.source = "qrc:/sounds/C2_523Hz.wav"; toneText.text = text } }
                MenuItem { text: "D2 587Hz"; onClicked: { playSound.source = "qrc:/sounds/D2_587Hz.wav"; toneText.text = text } }
                MenuItem { text: "E2 659Hz"; onClicked: { playSound.source = "qrc:/sounds/E2_659Hz.wav"; toneText.text = text } }
                MenuItem { text: "F2 698Hz"; onClicked: { playSound.source = "qrc:/sounds/F2_698Hz.wav"; toneText.text = text } }
                MenuItem { text: "G2 784Hz"; onClicked: { playSound.source = "qrc:/sounds/G2_784Hz.wav"; toneText.text = text } }
                MenuItem { text: "A2 880Hz"; onClicked: { playSound.source = "qrc:/sounds/A2_880Hz.wav"; toneText.text = text } }
                MenuItem { text: "B2 988Hz"; onClicked: { playSound.source = "qrc:/sounds/B2_988Hz.wav"; toneText.text = text } }

            }
        }
        Label {
            id: toneText
            Layout.alignment: Qt.AlignHCenter
            text: "A1 440Hz"
            font.pixelSize: fontSizeSubheading
        }
    }

    Rectangle {
        id: sbutton
        anchors.centerIn: parent
        property int size: isLandscape ? parent.height/2 : parent.width/2
        width: size ; height: size;
        radius: size/2
        color: "orange"
        border.color: "white"
        border.width: 4

        SoundEffect {
            id: playSound
            source: "qrc:/sounds/A1_440Hz.wav"
            loops: SoundEffect.Infinite
        }
        MouseArea {
            id: playArea
            anchors.fill: parent
            onPressed: {
                playSound.play()
                sbutton.color = "darkorange"
            }
            onReleased: {
                playSound.stop()
                sbutton.color = "orange"
            }
        }
    }

    Popup {
        id: aboutDialog
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: appWindow.height / 6
        width: Math.min(appWindow.width, appWindow.height) / 3 * 2
        contentHeight: aboutColumn.height

        Column {
            id: aboutColumn
            spacing: 20

            Label {
                width: aboutDialog.availableWidth
                text: "O aplikaci Zvuček"
                font.bold: true
                font.pixelSize: fontSizeTitle
            }

            Label {
                width: aboutDialog.availableWidth
                text: "Autor: Martin Farník\n<martin.farnik@email.cz>"
                font.bold: true
                font.pixelSize: fontSizeSubheading
                wrapMode: Label.Wrap
            }

            Label {
                width: aboutDialog.availableWidth
                text: "Aplikace slouží jako pomůcka v logopedii."
                font.pixelSize: fontSizeBodyAndButton
                wrapMode: Label.Wrap
            }

            Label {
                width: aboutDialog.availableWidth
                text: "Aplikace je distribuovaná pod licencí <a href=\"https://www.apache.org/licenses/LICENSE-2.0.txt\">Apache 2.0</a>"
                onLinkActivated: Qt.openUrlExternally(link)
                wrapMode: Label.Wrap
                font.pixelSize: fontSizeCaption
            }
            Label {
                width: aboutDialog.availableWidth
                text: "Zdrojový kod aplikace je možno stáhnout na adrese <a href=\"https://github.com/cmarty/Zvucek\">https://github.com/cmarty/Zvucek</a>"
                onLinkActivated: Qt.openUrlExternally(link)
                wrapMode: Label.Wrap
                font.pixelSize: fontSizeCaption
            }
            Label {
                width: aboutDialog.availableWidth
                text: "Tato aplikace používá Qt knihovnu pod licencí <a href=\"https://www.gnu.org/licenses/lgpl-3.0-standalone.html\">LGPL v3.0</a>"
                onLinkActivated: Qt.openUrlExternally(link)
                wrapMode: Label.Wrap
                font.pixelSize: fontSizeCaption
            }

            Label {
                width: aboutDialog.availableWidth
                text: "Zdrojové kody Qt knihovny je možno stáhnout na adrese <a href=\"http://www.qt.io/download-open-source/\">http://qt.io/download-open-source/</a>"
                wrapMode: Label.Wrap
                font.pixelSize: fontSizeCaption
            }
        }
    }

}
