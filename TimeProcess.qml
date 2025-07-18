pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    property string format: "dddd\nHH\nMM"

    readonly property string curr_time: {
        // The passed format string matches the default output of
        // the `date` command.
        Qt.formatDateTime(clock.date, format);
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
