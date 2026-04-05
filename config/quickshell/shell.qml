import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
  id: root

  // Catppuccin Mocha
  property color surface0:  "#313244"
  property color surface1:  "#45475a"
  property color overlay0:  "#6c7086"
  property color text:      "#cdd6f4"
  property color subtext1:  "#bac2de"
  property color blue:      "#89b4fa"
  property color green:     "#a6e3a1"
  property color mauve:     "#cba6f7"

  property string fontFamily: "JetBrainsMono Nerd Font"
  property int    fontSize:   13

  anchors.top:   true
  anchors.left:  true
  anchors.right: true
  implicitHeight: 40
  color: "transparent"

  component Pill: Rectangle {
    property alias content: inner.data
    implicitHeight: 28
    implicitWidth:  inner.implicitWidth + 20
    radius: 14
    color: Qt.rgba(0.19, 0.19, 0.27, 0.90)
    border.color: root.surface1
    border.width: 1

    RowLayout {
      id: inner
      anchors.centerIn: parent
      spacing: 6
    }
  }

  RowLayout {
    anchors.fill:         parent
    anchors.leftMargin:   10
    anchors.rightMargin:  10
    anchors.topMargin:    6
    anchors.bottomMargin: 6
    spacing: 6

    // Workspaces
    Pill {
      content: [
        Text {
          text: ""
          font { family: root.fontFamily; pixelSize: root.fontSize + 2 }
          color: root.blue
        },

        Text {
          text: ""
          font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
          color: root.text
        },

        Repeater {
          model: 5
          delegate: Item {
            implicitWidth:  wsText.implicitWidth + 4
            implicitHeight: wsText.implicitHeight

            property var  ws:       Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
            property bool hasWin:   !!ws

            Text {
              id: wsText
              anchors.centerIn: parent
              text: isActive ? "●" : (hasWin ? "◉" : "○")
              font { family: root.fontFamily; pixelSize: root.fontSize }
              color: isActive ? root.green
                   : hasWin  ? root.blue
                   :            root.overlay0
              Behavior on color { ColorAnimation { duration: 150 } }
            }

            MouseArea {
              anchors.fill: parent
              onClicked: Hyprland.dispatch("workspace " + (index + 1))
              cursorShape: Qt.PointingHandCursor
            }
          }
        }
      ]
    }

    // Fill item
    Item { Layout.fillWidth: true }

    // Clock
    Pill {
      content: [
        Text {
          id: clock
          font { family: root.fontFamily; pixelSize: root.fontSize }
          color: root.text
          text: Qt.formatDateTime(new Date(), "ddd dd MMM HH:mm")
        }
      ]

      Timer {
        interval: 1000
        running:  true
        repeat:   true
        onTriggered: {
          clock.text = Qt.formatDateTime(new Date(), "ddd dd MMM HH:mm")
        }
      }
    }
  }
}
