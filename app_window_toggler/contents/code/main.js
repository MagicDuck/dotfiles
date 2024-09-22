let currentActiveWinId = null
let lastActiveWinId = null
workspace.windowActivated.connect(function(win) {
    lastActiveWinId = currentActiveWinId
    currentActiveWinId = win.internalId
})

function toggleApp(name)
{
    const win = workspace.stackingOrder.find(function(w) {
        return w.resourceClass === name || w.resourceName === name
    })

    if (!win) {
        // launch app in future
        return
    }

    if (workspace.activeWindow === win) {
        console.info('activating last active thing', lastActiveWinId)
        const lastWin = workspace.stackingOrder.find(function(w) {
            return w.internalId === lastActiveWinId
        })
        if (lastWin) {
            workspace.activeWindow = lastWin
        }
    } else {
        workspace.activeWindow = win
    }
}

function getToggleApp2(name) {
    return function() {
        toggleApp(name)
    }
}

function registerToggleAppShortcut(name, key) {
    const prefix = 'Meta+Ctrl+Alt+Shift+'
    const shortcut = prefix + key
    const title = 'toggle app ' + name
    const callback = function() { toggleApp(name) }
    registerShortcut(title, title, shortcut, callback)
}

registerToggleAppShortcut('dolphin', 'P')
registerToggleAppShortcut('firefox', 'R')
registerToggleAppShortcut('wezterm-gui', 'e')
registerToggleAppShortcut('brave-browser', 'd')
