const time = Variable('', {
    poll: [1000, function() {
        return Date().toString()
    }],
})

const Bar = Widget.Window({
    monitor: 0,
    name: `bar1`,
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        spacing: 1,
        start_widget: Widget.Button({
            child: Widget.Label("󱄅 ")
        }),
        end_widget: Widget.Label({
            hpack: 'center',
            label: time.bind(),
        }),
    }),
})

App.config({
    windows: [Bar],
})
