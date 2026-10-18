import QtQuick
import qs.Commons

// Night light page. Small on purpose: this section is one switch and one fact.
Item {
  id: page

  property var state: null
  property var host: null

  implicitHeight: col.implicitHeight

  component Caps: Text {
    color: Util.alpha(Color.foreground, 0.45)
    font.family: Style.font.family
    font.pixelSize: Style.font.caption
    font.letterSpacing: 1.5
  }

  component Rule: Rectangle {
    width: parent ? parent.width : 0
    height: 1
    color: Util.alpha(Color.foreground, 0.1)
  }

  Column {
    id: col
    width: parent.width
    spacing: Style.space(2)

    // ---- switch row ----
    Item {
      width: parent.width
      height: Style.space(34)

      Text {
        anchors.left: parent.left
        anchors.leftMargin: Style.space(8)
        anchors.verticalCenter: parent.verticalCenter
        text: "Enabled"
        color: Color.foreground
        font.family: Style.font.family
        font.pixelSize: Style.font.body
      }

      Rectangle {
        anchors.right: parent.right
        anchors.rightMargin: Style.space(8)
        anchors.verticalCenter: parent.verticalCenter
        width: Style.space(34)
        height: Style.space(18)
        radius: height / 2
        color: page.state && page.state.active
          ? Util.alpha(Color.accent, 0.85)
          : Util.alpha(Color.foreground, 0.2)

        Rectangle {
          width: Style.space(14)
          height: width
          radius: width / 2
          y: (parent.height - height) / 2
          x: page.state && page.state.active ? parent.width - width - Style.space(2) : Style.space(2)
          color: "#ffffff"
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: if (page.state) page.state.toggle()
        }
      }
    }

    // ---- temperature ----
    Item {
      width: parent.width
      height: Style.space(28)
      visible: page.state ? page.state.active : false

      Text {
        anchors.left: parent.left
        anchors.leftMargin: Style.space(8)
        anchors.verticalCenter: parent.verticalCenter
        text: "Temperature"
        color: Util.alpha(Color.foreground, 0.55)
        font.family: Style.font.family
        font.pixelSize: Style.font.body
      }

      Text {
        anchors.right: parent.right
        anchors.rightMargin: Style.space(8)
        anchors.verticalCenter: parent.verticalCenter
        text: page.state && page.state.temperature > 0
          ? page.state.temperature + " K"
          : "—"
        color: Color.foreground
        font.family: Style.font.family
        font.pixelSize: Style.font.body
        font.bold: true
      }
    }

    Rule { }

    Text {
      width: parent.width
      height: Style.space(26)
      verticalAlignment: Text.AlignVCenter
      leftPadding: Style.space(8)
      text: "Managed by Omarchy's night light service"
      color: Util.alpha(Color.foreground, 0.45)
      font.family: Style.font.family
      font.pixelSize: Style.font.caption
    }
  }
}
