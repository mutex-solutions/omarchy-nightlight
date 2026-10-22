import QtQuick
import Quickshell
import Quickshell.Io

// Night light state.
//
// Omarchy owns this feature as a service plugin, and a third-party plugin is
// handed a scoped facade without service access, so the supported door is the
// command: `omarchy-toggle-nightlight --status` for reading and no argument for
// toggling. Reading it every ten seconds is cheap and keeps the tile honest if
// the toggle is flipped from the Omarchy menu.
Item {
  id: s

  property bool enabled: false
  property int temperature: 0

  readonly property bool active: enabled
  readonly property string label: "Night light"
  readonly property string icon: "󰖔"
  readonly property string detail: enabled
    ? (temperature > 0 ? temperature + " K" : "on")
    : "off"

  function refresh() {
    if (!statusProc.running) statusProc.running = true
  }

  function toggle() {
    if (!toggleProc.running) toggleProc.running = true
  }

  Process {
    id: statusProc
    command: ["omarchy-toggle-nightlight", "--status"]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        try {
          var parsed = JSON.parse(text || "{}")
          s.enabled = parsed.enabled === true
          s.temperature = Number(parsed.temperature || 0)
        } catch (e) {
        }
      }
    }
  }

  Process {
    id: toggleProc
    command: ["omarchy-toggle-nightlight"]
    // hyprsunset applies the temperature a moment after the command returns.
    onExited: settleTimer.restart()
  }

  Timer {
    id: settleTimer
    interval: 500
    onTriggered: s.refresh()
  }

  Timer {
    interval: 10000
    running: true
    repeat: true
    onTriggered: s.refresh()
  }

  Component.onCompleted: refresh()
}
