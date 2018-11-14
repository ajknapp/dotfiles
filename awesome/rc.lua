-- {{{ License
--
-- Awesome configuration, using awesome 3.4.5 on Arch GNU/Linux
--   * Adrian C. <anrxc@sysphere.org>

-- Screenshot: http://sysphere.org/gallery/snapshots

-- This work is licensed under the Creative Commons Attribution-Share
-- Alike License: http://creativecommons.org/licenses/by-sa/3.0/
-- }}}


-- {{{ Libraries
gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
awful.autofocus = require("awful.autofocus")
awful.placement = require("awful.placement")
-- User libraries
vicious = require("vicious")
scratch = require("scratch")
naughty = require("naughty")
beautiful = require("beautiful")
wibox = require("wibox")
align = require("wibox.layout.align")
fixed = require("wibox.layout.fixed")
flex  = require("wibox.layout.flex")
-- Live hacking
awful.remote = require("awful.remote")
-- }}}


-- {{{ Variable definitions
local altkey = "Mod1"
local modkey = "Mod4"

local home   = os.getenv("HOME")
local exec   = awful.util.spawn
local sexec  = awful.util.spawn_with_shell

-- Beautiful theme
beautiful.init(home .. "/.config/awesome/zenburn.lua")
beautiful.fg_widget = "#AECF96"
beautiful.fg_center_widget = "#88A175"
beautiful.fg_end_widget = "#FF5656"
beautiful.fg_netup_widget  = "#7F9F7F"
beautiful.fg_urgent = "#CC9393"
beautiful.fg_netdn_widget  = beautiful.fg_urgent
beautiful.fg_normal = "#DCDCCC"

-- Window management layouts
layouts = {
  awful.layout.suit.tile,        -- 1
  awful.layout.suit.tile.bottom, -- 2
  awful.layout.suit.fair,        -- 3
  awful.layout.suit.max,         -- 4
  awful.layout.suit.magnifier,   -- 5
  awful.layout.suit.floating     -- 6
}
-- }}}


-- {{{ Tags
tags = {
  names  = { "term", "emacs", "web", "mail", "im", "docs", "media", 8, 9 },
  layout = { layouts[2], layouts[1], layouts[1], layouts[4], layouts[1],
             layouts[5], layouts[1], layouts[6], layouts[6]
}}

for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
    awful.tag.setproperty(tags[s][2], "mwfact", 0.50)
    awful.tag.setproperty(tags[s][5], "mwfact", 0.17)
    awful.tag.setproperty(tags[s][8], "hide",   true)
    awful.tag.setproperty(tags[s][9], "hide",   true)
end

-- }}}


-- {{{ Wibox
--
-- {{{ Widgets configuration
--
-- {{{ Reusable separator
separator = wibox.widget.imagebox()
separator:set_image(beautiful.widget_sep)
-- }}}

-- {{{ CPU usage and temperature
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)
-- Initialize widgets
cpuwidget = awful.widget.graph()
cpugraph = wibox.widget {
  {
    widget = cpuwidget,
    forced_width = 40*2,
    forced_height = 12*2,
    background_color = gears.color(beautiful.fg_off_widget),
    color = gears.color("linear:0,0:8,14:0," .. beautiful.fg_end_widget .. ":0.5," .. beautiful.fg_center_widget .. ":1," .. beautiful.fg_widget)
  },
  layout = wibox.container.rotate,
}
-- cpugraph  = awful.widget.graph()
tzswidget = wibox.widget.textbox()
-- Graph properties
-- cpugraph:set_width(40):set_height(14)
-- cpugraph:set_background_color(beautiful.fg_off_widget)
-- cpugraph:set_gradient_angle(0):set_gradient_colors({
--    beautiful.fg_end_widget, beautiful.fg_center_widget, beautiful.fg_widget
-- })


-- cpugraph:set_color("linear:0,0:8,14:0," .. beautiful.fg_end_widget ..
-- 		   ":0.5," .. beautiful.fg_center_widget .. ":1," .. beautiful.fg_widget)
-- Register widgets
vicious.register(cpuwidget,  vicious.widgets.cpu,      "$1")
vicious.register(tzswidget, vicious.widgets.thermal, " $1°C", 19, "thermal_zone0")
-- }}}

-- {{{ Battery state
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.widget_bat)
-- Initialize widget
batwidget = wibox.widget.textbox()
-- Register widget
vicious.register(batwidget, vicious.widgets.bat,
        function (widget, args)
                if args[2] == 0 then return ""
                else
			return args[1]..args[2].."%"
                end
        end, 61, "BAT0"
)
-- vicious.register(batwidget, vicious.widgets.bat, "$1$2%", 61, "BAT0")
-- }}}

-- {{{ Memory usage
memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.widget_mem)
-- Initialize widget
memwidget = wibox.widget.progressbar()
membar = wibox.widget {
  {
    widget = memwidget,
    -- color = "linear:0,0:8,14:0," .. beautiful.fg_end_widget .. ":0.5," .. beautiful.fg_center_widget .. ":1," .. beautiful.fg_widget,
    color = { type="linear", from = {0, 0}, to = {12*2, 0}, stops = {
                {0 , beautiful.fg_widget},
                {0.5, beautiful.fg_center_widget},
                {1.0, beautiful.fg_end_widget} }
            },
    background_color = beautiful.fg_off_widget,
    ticks = true,
    ticks_size = 4,
  },
  direction = "east",
  forced_height = 12*2,
  forced_width = 8*2,
  layout = wibox.container.rotate
}
-- membar = awful.widget.progressbar()
-- membar:set_vertical(true):set_ticks(true)
-- membar:set_height(12):set_width(8):set_ticks_size(2)
-- membar:set_background_color(beautiful.fg_off_widget)
-- membar:set_gradient_colors({ beautiful.fg_widget,
--    beautiful.fg_center_widget, beautiful.fg_end_widget
-- })
-- membar:set_color("linear:0,0:8,14:0," .. beautiful.fg_end_widget ..
-- 		 ":0.5," .. beautiful.fg_center_widget .. ":1," .. beautiful.fg_widget)
-- Register widget
vicious.register(memwidget, vicious.widgets.mem, "$1", 13)
-- }}}

-- {{{ File system usage
fsicon = wibox.widget.imagebox()
fsicon:set_image(beautiful.widget_fs)
-- Initialize widgets
fswidget = wibox.widget.progressbar()
r = wibox.widget {
  {
    widget = fswidget,
    ticks = true,
    ticks_size = 2*2,
    border_color = beautiful.border_widget,
    background_color = beautiful.fg_off_widget,
    -- color = "linear:0,0:8,14:0," .. beautiful.fg_end_widget .. ":0.5," .. beautiful.fg_center_widget .. ":1," .. beautiful.fg_widget,
    color = { type="linear", from = {0, 0}, to = {12*2, 0}, stops = {
                {0 , beautiful.fg_widget},
                {0.5, beautiful.fg_center_widget},
                {1.0, beautiful.fg_end_widget} }
            },
  },
  direction = 'east',
  forced_width = 8*2,
  forced_height = 12*2,
  layout = wibox.container.rotate,
}
-- r = awful.widget.progressbar()
-- -- Progressbar properties
-- r:set_vertical(true):set_ticks(true)
-- r:set_height(14):set_width(5):set_ticks_size(2)
-- r:set_border_color(beautiful.border_widget)
-- r:set_background_color(beautiful.fg_off_widget)
-- r:set_color("linear:0,0:8,14:0," .. beautiful.fg_end_widget ..
-- 	    ":0.5," .. beautiful.fg_center_widget .. ":1," .. beautiful.fg_widget)
-- r:set_gradient_colors({ beautiful.fg_widget,
-- 			 beautiful.fg_center_widget, beautiful.fg_end_widget
-- 		      })
-- Register buttons
r:buttons(awful.util.table.join(awful.button({ }, 1, function () exec("rox", false) end)))
-- Enable caching
vicious.cache(vicious.widgets.fs)
-- Register widgets
vicious.register(fswidget, vicious.widgets.fs, "${/ used_p}",            599)
-- vicious.register(fs.h, vicious.widgets.fs, "${/home used_p}",        599)
-- }}}

-- {{{ Network usage
dnicon = wibox.widget.imagebox()
upicon = wibox.widget.imagebox()
dnicon:set_image(beautiful.widget_net)
upicon:set_image(beautiful.widget_netup)
-- Initialize widget
netwidget = wibox.widget.textbox()
-- Register widget
vicious.register(netwidget, vicious.widgets.net, '<span color="'
  .. beautiful.fg_netdn_widget ..'">${wlp5s0 down_kb}</span> <span color="'
  .. beautiful.fg_netup_widget ..'">${wlp5s0 up_kb}</span>', 3)
-- }}}

-- {{{ Org-mode agenda
-- the current agenda popup
org_agenda_popup = nil

-- do some highlighting and show the popup
function show_org_agenda ()
   local fd = io.open("/tmp/org-agenda.txt", "r")
   if not fd then
      return
   end
   local text = fd:read("*a")
   fd:close()
   -- highlight week agenda line
   text = text:gsub("(Week%-agenda[ ]+%(W%d%d?%):)", "%1")
   -- highlight dates
   text = text:gsub("(%w+[ ]+%d%d? %w+ %d%d%d%d[^\n]*)", "<span color='"..beautiful.fg_widget.."'>%1</span>")
   -- highlight times
   text = text:gsub("(%d%d?:%d%d)", "<span color='#8cd0d3'>%1</span> ")
   -- highlight tags
   text = text:gsub("(:[^ ]+:)([ ]*\n)", "<span color='#f0dfaf'>%1%2</span>")
   -- highlight TODOs
   text = text:gsub("(TODO) ", "<span color='"..beautiful.fg_urgent.. "'><b>%1</b></span> ")
   -- highlight DONEs
   text = text:gsub("(DONE) ", "<span color='"..beautiful.fg_netup_widget.. "'><b>%1</b></span> ")
   -- highlight categories
   text = text:gsub("([ ]+%w+:) ", "<span color='#dfaf8f'>%1</span> ")
   org_agenda_popup = naughty.notify(
      { text     = text,
        timeout  = 999999999,
        width    = 600,
        screen   = mouse.screen })
end

-- dispose the popup
function dispose_org_agenda ()
   if org_agenda_popup ~= nil then
      naughty.destroy(org_agenda_popup)
      org_agenda_popup = nil
   end
end

orgicon = wibox.widget.imagebox()
orgicon:set_image(beautiful.widget_org)
-- Initialize widget
orgwidget = wibox.widget.textbox()
-- Configure widget
local orgmode = {
  files = {
    "/home/andy/test.org"
  },
  color = {
    past   = '<span color="'..beautiful.fg_urgent..'">',
    today  = '<span color="'..beautiful.fg_normal..'">',
    soon   = '<span color="'..beautiful.fg_widget..'">',
    future = '<span color="'..beautiful.fg_netup_widget..'">'
}} -- Register widget
vicious.register(orgwidget, vicious.widgets.org,
  orgmode.color.past..'$1</span>-'..orgmode.color.today .. '$2</span>-' ..
  orgmode.color.soon..'$3</span>-'..orgmode.color.future.. '$4</span>', 601,
  orgmode.files
) -- Register buttons
orgwidget:buttons(awful.util.table.join(
  awful.button({ }, 1, function () exec("emacsclient --eval '(org-agenda-list)'") end),
  awful.button({ }, 3, function () exec("emacsclient --eval '(make-capture-frame)'") end)
))

orgwidget:connect_signal("mouse::enter", show_org_agenda)
orgwidget:connect_signal("mouse::leave", dispose_org_agenda)
orgicon:connect_signal("mouse::enter", show_org_agenda)
orgicon:connect_signal("mouse::leave", dispose_org_agenda)

-- }}}

-- {{{ Volume level
volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.widget_vol)
-- Initialize widgets
volbarwidget = wibox.widget.progressbar()
volbar = wibox.widget {
  {
    ticks = true,
    ticks_size = 2,
    color = { type="linear", from = {0, 0}, to = {12*2, 0}, stops = {
                {0 , beautiful.fg_widget},
                {0.5, beautiful.fg_center_widget},
                {1.0, beautiful.fg_end_widget} }
    },
    -- color = "linear:0,0:8,14:0," .. beautiful.fg_end_widget .. ":0.5," .. beautiful.fg_center_widget .. ":1," .. beautiful.fg_widget,
    background_color = beautiful.fg_off_widget,
    widget = volbarwidget,
  },
  direction = "east",
  forced_height = 12*2,
  forced_width = 8*2,
  layout = wibox.container.rotate
}
volwidget = wibox.widget.textbox()
-- volbar    = awful.widget.progressbar()
-- -- Progressbar properties
-- volbar:set_vertical(true):set_ticks(true)
-- volbar:set_height(12):set_width(8):set_ticks_size(2)
-- volbar:set_background_color(beautiful.fg_off_widget)
-- volbar:set_gradient_colors({ beautiful.fg_widget,
--    beautiful.fg_center_widget, beautiful.fg_end_widget
-- }) -- Enable caching
-- volbar:set_color("linear:0,0:8,14:0," .. beautiful.fg_end_widget ..
-- 		 ":0.5," .. beautiful.fg_center_widget .. ":1," .. beautiful.fg_widget)
vicious.cache(vicious.widgets.volume)
-- Register widgets
vicious.register(volbarwidget, vicious.widgets.volume, "$1", 2, "Master")
vicious.register(volwidget, vicious.widgets.volume, "$1%", 2, "Master")
-- Register buttons
volbar:buttons(awful.util.table.join(
   awful.button({ }, 1, function () exec("/home/andy/bin/mute-pa") end),
   awful.button({ }, 4, function () exec("/home/andy/bin/vol+", false) end),
   awful.button({ }, 5, function () exec("/home/andy/bin/vol-", false) end)
)) -- Register assigned buttons
volwidget:buttons(volbar:buttons())
-- }}}

-- {{{ Date and time
dateicon = wibox.widget.imagebox()
dateicon:set_image(beautiful.widget_date)
-- Initialize widget
datewidget = wibox.widget.textbox()
-- Register widget
vicious.register(datewidget, vicious.widgets.date, "%R", 61)
-- Register buttons
datewidget:buttons(awful.util.table.join(
  awful.button({ }, 1, function () exec("pylendar.py") end)
))
-- }}}

-- {{{ System tray
systray = wibox.widget.systray()
-- }}}
-- }}}

-- {{{ Wibox initialisation
mywibox     = {}
promptbox = {}
layoutbox = {}
taglist   = {}
taglist.buttons = awful.util.table.join(
    awful.button({ },        1, awful.tag.viewonly),
    awful.button({ modkey }, 1, awful.client.movetotag),
    awful.button({ },        3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, awful.client.toggletag),
    awful.button({ },        4, awful.tag.viewnext),
    awful.button({ },        5, awful.tag.viewprev)
)

for s = 1, screen.count() do
    -- Create a promptbox
    promptbox[s] = wibox.widget.textbox()
    -- Create a layoutbox
    layoutbox[s] = awful.widget.layoutbox(s)
    layoutbox[s]:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc(layouts,  1) end),
        awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
        awful.button({ }, 4, function () awful.layout.inc(layouts,  1) end),
        awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)
    ))

    -- Create the taglist
    taglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist.buttons)
    -- Create the wibox
    mywibox[s] = awful.wibar({      screen = s,
        fg = beautiful.fg_normal, height = 12*2,
        bg = beautiful.bg_normal, position = "top",
        border_color = beautiful.border_focus,
        border_width = beautiful.border_width
    })

    -- mywibox[s]:setup{
    --   layout = align.horizontal,
    --   {
    --     taglist[s],
    --     layoutbox[s],
    --     separator,
    --     promptbox[s],
    --   },
    --   {separator}
    --   ,
    --   {
    --     cpuicon,
    --     cpugraph,
    --     tzswidget,
    --     separator,
    --     baticon,
    --     batwidget,
    --     separator,
    --     memicon,
    --     membar,
    --     separator,
    --     fsicon,
    --     fswidget,
    --     separator,
    --     dnicon,
    --     netwidget,
    --     upicon,
    --     separator,
    --     orgicon,
    --     orgwidget,
    --     separator,
    --     volicon,
    --     volbar,
    --     volwidget,
    --     separator,
    --     dateicon,
    --     datewidget,
    --     separator,
    --   }
    --               }

    local left_layout = fixed.horizontal()
    left_layout:add(taglist[s])
    left_layout:add(layoutbox[s])
    left_layout:add(separator)
    left_layout:add(promptbox[s])

    local right_layout = fixed.horizontal()
    right_layout:add(cpuicon)
    right_layout:add(cpugraph)
    right_layout:add(tzswidget)
    right_layout:add(separator)
    right_layout:add(baticon)
    right_layout:add(batwidget)
    right_layout:add(separator)
    right_layout:add(memicon)
    right_layout:add(membar)
    right_layout:add(separator)
    right_layout:add(fsicon)
    right_layout:add(r)
    right_layout:add(separator)
    right_layout:add(dnicon)
    right_layout:add(netwidget)
    right_layout:add(upicon)
    right_layout:add(separator)
    --        separator, mailwidget, mailicon,
    right_layout:add(orgicon)
    right_layout:add(orgwidget)
    right_layout:add(separator)
    right_layout:add(volicon)
    right_layout:add(volbar)
    right_layout:add(volwidget)
    right_layout:add(separator)
    right_layout:add(dateicon)
    right_layout:add(datewidget)
    right_layout:add(separator)

    local layout = align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)

    -- Add widgets to the wibox
    -- wibox[s].widgets = {
--         {   taglist[s], layoutbox[s], separator, promptbox[s]
--             -- ["layout"] = awful.widget.layout.horizontal.leftright
--         },
--         s == screen.count() and systray or nil,
--         separator, datewidget, dateicon,
--         separator, volwidget,  volbar.widget, volicon,
--         separator, orgwidget,  orgicon,
-- --        separator, mailwidget, mailicon,
--         separator, upicon,     netwidget, dnicon,
--         separator, r.widget,          fsicon,
--         separator, membar.widget, memicon,
--         separator, batwidget, baticon,
--         separator, tzswidget, cpugraph.widget, cpuicon
--         -- separator, ["layout"] = awful.widget.layout.horizontal.rightleft
--     }
end
-- }}}
-- }}}


-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- Client bindings
clientbuttons = awful.util.table.join(
    awful.button({ },        1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)
-- }}}


-- {{{ Key bindings
--
-- {{{ Global keys
globalkeys = gears.table.join(
    -- {{{ Applications
    awful.key({ modkey, "Control" }, "Delete", function () exec("slimlock") end),
    awful.key({ modkey }, "e", function () exec("emacsclient -n -c -e '(switch-to-buffer nil)'") end),
    awful.key({ modkey }, "c", function () exec("chromium") end),
    awful.key({ modkey }, "v", function () exec("emacsclient -e '(make-vm-frame)'") end),
    awful.key({ modkey }, "r", function () exec("emacsclient -e '(make-capture-frame)'") end),
    awful.key({ modkey }, "n", function () exec("emacsclient -e '(make-newsticker-frame)'") end),
    awful.key({ modkey }, "i", function () exec("emacsclient -e '(make-erc-frame)'") end),
    awful.key({ modkey }, "p", function () exec("emacsclient -e '(make-emms-frame')") end),
    awful.key({ modkey }, "w", function () exec("emacsclient -e '(make-w3m-frame)'") end),
    awful.key({ modkey }, "Return", function () exec("urxvt -fn 'xft:Consolas:size=9,xft:Droid Sans Fallback:size=6'") end),
    -- }}}

    -- {{{ Multimedia keys
    awful.key({}, "XF86AudioMute", function () exec("/home/andy/bin/mute-pa") end),
    awful.key({}, "XF86AudioRaiseVolume", function () exec("/home/andy/bin/vol+") end),
    awful.key({}, "XF86AudioLowerVolume", function () exec("/home/andy/bin/vol-")  end),
    awful.key({}, "XF86AudioPrev", function () exec("emacsclient -e '(emms-previous)'") end),
    awful.key({}, "XF86AudioPlay", function () exec("emacsclient -e '(emms-pause)'") end),
    awful.key({}, "XF86AudioNext", function () exec("emacsclient -e '(emms-next)'") end),
    awful.key({}, "Print", function () exec("import -window root ~/screenshot.png") end),
    -- }}}

    -- {{{ Prompt menus
    awful.key({ modkey }, "F1", function () scratch.drop("urxvt", "bottom") end),
    awful.key({ modkey }, "F2", function ()
        -- awful.prompt.run({ prompt = "Run: " }, promptbox[mouse.screen].widget,
        --     function (t) promptbox[mouse.screen].text = sexec(t) end,
        --     awful.completion.shell, awful.util.getdir("cache") .. "/history")
        awful.prompt.run{
          prompt = "Run: ",
          textbox = promptbox[1],
          done_callback = function (result)
            atextbox.widget.text =
              type(result) == 'string' and result or ''
          end,
          exe_callback = sexec,
        }
    end),
    awful.key({ modkey }, "F3", function ()
        -- awful.prompt.run({ prompt = "Dictionary: " }, promptbox[mouse.screen].widget,
        --     function (word)
        --         sexec('notify-send "`sdcv -n '..word..'`"')
        --     end)
        awful.prompt.run{
          prompt = "Dictionary: ",
          textbox = promptbox[1],
          done_callback = function (result)
            atextbox.widget.text =
              type(result) == 'string' and result or ''
          end,
          exe_callback = function(word)
            sexec('notify-send -t 7000 "`sdcv -n '..word..'`"')
          end,
        }
    end),
    awful.key({ modkey }, "F4", function ()
        -- awful.prompt.run({ prompt = "Web: " }, promptbox[mouse.screen].widget,
        --     function (command)
        --         sexec("chromium 'http://yubnub.org/parser/parse?command="..command.."'")
        --         awful.tag.viewonly(tags[screen.count()][3])
        --     end)
        awful.prompt.run{
          prompt = "Web: ",
          textbox = promptbox[1],
          done_callback = function (result)
            atextbox.widget.text =
              type(result) == 'string' and result or ''
          end,
          exe_callback = function(command)
            sexec('palemoon "http://yubnub.org/parser/parse?command='..command..'"; sleep 0.125')
          end,
        }
    end),
    awful.key({ modkey }, "F5", function ()
        awful.prompt.run({ prompt = "Lua: " }, promptbox[mouse.screen].widget,
        awful.util.eval, nil, awful.util.getdir("cache") .. "/history_eval")
    end),
    -- }}}

    -- {{{ Awesome controls
    awful.key({ modkey }, "b", function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    end),
    awful.key({ modkey, "Shift" }, "q", awesome.quit),
    awful.key({ modkey, "Shift" }, "r", function ()
        promptbox[mouse.screen].text = awful.util.escape(awesome.restart())
    end),
    -- }}}

    -- {{{ Layout manipulation
    awful.key({ modkey }, "l",          function () awful.tag.incmwfact( 0.05) end),
    awful.key({ modkey }, "h",          function () awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Shift" }, "l", function () awful.client.incwfact(-0.05) end),
    awful.key({ modkey, "Shift" }, "h", function () awful.client.incwfact( 0.05) end),
    awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey },          "space", function () awful.layout.inc(layouts,  1) end),
    -- }}}

    -- {{{ Focus controls
--    awful.key({ modkey }, "p", function () awful.screen.focus_relative(1) end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey }, "s", function () scratch.pad.toggle() end),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey }, "j", function ()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey }, "k", function ()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey }, "Tab", function ()
        awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey }, "Escape", function ()
        awful.menu.menu_keys.down = { "Down", "Super_L" }
        local cmenu = awful.menu.clients({width=230}, { keygrabber=true, coords={x=525, y=330} })
    end),
    awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(1)  end),
    awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx(-1) end)
    -- }}}
)
-- }}}

-- {{{ Client manipulation
clientkeys = awful.util.table.join(
--    awful.key({ modkey }, "c", function (c) c:kill() end),
    awful.key({ modkey }, "d", function (c) scratch.pad.set(c, 0.60, 0.60, true) end),
    awful.key({ modkey }, "f", function (c) awful.titlebar(c, { size = 0 })
        c.fullscreen           = not c.fullscreen
    end),
    awful.key({ modkey }, "m", function (c)
        c.maximized_horizontal = not c.maximized_horizontal
        c.maximized_vertical   = not c.maximized_vertical
    end),
    awful.key({ modkey }, "o",     awful.client.movetoscreen),
    awful.key({ modkey }, "Next",  function () awful.client.moveresize( 20,  20, -40, -40) end),
    awful.key({ modkey }, "Prior", function () awful.client.moveresize(-20, -20,  40,  40) end),
    awful.key({ modkey }, "Down",  function () awful.client.moveresize(  0,  20,   0,   0) end),
    awful.key({ modkey }, "Up",    function () awful.client.moveresize(  0, -20,   0,   0) end),
    awful.key({ modkey }, "Left",  function () awful.client.moveresize(-20,   0,   0,   0) end),
    awful.key({ modkey }, "Right", function () awful.client.moveresize( 20,   0,   0,   0) end),
    awful.key({ modkey, "Control"},"r", function (c) c:redraw() end),
    awful.key({ modkey, "Shift" }, "0", function (c) c.sticky = not c.sticky end),
    awful.key({ modkey, "Shift" }, "m", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey, "Shift" }, "c", function (c) sexec("kill -CONT " .. c.pid) end),
    awful.key({ modkey, "Shift" }, "s", function (c) sexec("kill -STOP " .. c.pid) end),
    awful.key({ modkey, "Shift" }, "f", function (c) if awful.client.floating.get(c)
        then awful.client.floating.delete(c);    awful.titlebar(c, { size = 0 })
        else awful.client.floating.set(c, true); awful.titlebar(c) end
    end),
    awful.key({ modkey, "Shift" }, "t", function (c)
					   -- toggle titlebar
					   if (c:titlebar_top():geometry()['height'] > 0) then
					      awful.titlebar(c, {size = 0})
					   else
					      awful.titlebar(c)
					   end
					end)
)
-- }}}

function add_titlebar(c)
   -- buttons for the titlebar
   local buttons = awful.util.table.join(
					 awful.button({ }, 1, function()
								 client.focus = c
								 c:raise()
								 awful.mouse.client.move(c)
							      end),
					 awful.button({ }, 3, function()
								 client.focus = c
								 c:raise()
								 awful.mouse.client.resize(c)
							      end)
				      )

   -- Widgets that are aligned to the left
   local left_layout = fixed.horizontal()
   left_layout:add(awful.titlebar.widget.iconwidget(c))
   left_layout:buttons(buttons)

   -- Widgets that are aligned to the right
   local right_layout = fixed.horizontal()
   right_layout:add(awful.titlebar.widget.floatingbutton(c))
   right_layout:add(awful.titlebar.widget.maximizedbutton(c))
   right_layout:add(awful.titlebar.widget.stickybutton(c))
   right_layout:add(awful.titlebar.widget.ontopbutton(c))
   right_layout:add(awful.titlebar.widget.closebutton(c))

   -- The title goes in the middle
   local middle_layout = flex.horizontal()
   local title = awful.titlebar.widget.titlewidget(c)
   title:set_align("center")
   middle_layout:add(title)
   middle_layout:buttons(buttons)

   -- Now bring it all together
   local layout = align.horizontal()
   layout:set_left(left_layout)
   layout:set_right(right_layout)
   layout:set_middle(middle_layout)

   awful.titlebar(c):set_widget(layout)
end

-- {{{ Keyboard digits
local keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags, keynumber));
end
-- }}}

-- {{{ Tag controls
-- for i = 1, keynumber do
--     globalkeys = gears.table.join( globalkeys,
--         awful.key({ modkey }, "#" .. i + 9, function ()
--             local screen = mouse.screen
--             if tags[screen][i] then awful.tag.viewonly(tags[screen][i]) end
--         end),
--         awful.key({ modkey, "Control" }, "#" .. i + 9, function ()
--             local screen = mouse.screen
--             if tags[screen][i] then awful.tag.viewtoggle(tags[screen][i]) end
--         end),
--         awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
--             if client.focus and tags[client.focus.screen][i] then
--                 awful.client.movetotag(tags[client.focus.screen][i])
--             end
--         end),
--         awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function ()
--             if client.focus and tags[client.focus.screen][i] then
--                 awful.client.toggletag(tags[client.focus.screen][i])
--             end
--         end))
-- end

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end
-- }}}

-- Set keys
root.keys(globalkeys)
-- }}}


-- {{{ Rules
awful.rules.rules = {
    { rule = { }, properties = {
      focus = true,      size_hints_honor = false,
      keys = clientkeys, buttons = clientbuttons,
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal }
    },
    {  rule = { class = "Firefox",  instance = "Navigator" },
       properties = { tag = tags[screen.count()][3] } },
    {  rule = { class = "Chromium" },
       properties = {tag = tags[screen.count()][3] } },
    {  rule = { class = "Conkeror" },
       properties = {tag = tags[screen.count()][3] } },
    {  rule = { class = "Pale moon" },
       properties = {tag = tags[screen.count()][3] } },
    {  rule = { class = "Emacs",    name = ".*ansi-term.*" },
       properties = { tag = tags[screen.count()][1] }, },
    {  rule = { class = "Emacs",    name = "*capture*" },
       properties = { floating = true },
       callback = function (c)
		     awful.placement.centered(c, nil)
		  end},
    {  rule = { class = "Emacs",    name = "*w3m*" },
       properties = { tag = tags[screen.count()][3] } },
    {  rule = { class = "Emacs",    name = "*vm*" },
       properties = { tag = tags[screen.count()][4] } },
    {  rule = { class = "Emacs",    name = "*erc*" },
       properties = { tag = tags[screen.count()][5] } },
    {  rule = { class = "Emacs",    name = "*newsticker*" },
       properties = { tag = tags[screen.count()][6] } },
    {  rule = { class = "Emacs",    name = "*emms*" },
       properties = { tag = tags[screen.count()][7] } },
    {  rule = { class = "Emacs",    instance = "emacs" },
       properties = { tag = tags[screen.count()][2] } },
    {  rule = { class = "Xmessage", instance = "xmessage" },
       properties = { floating = true }, callback = awful.titlebar },
    {  rule = { instance = "firefox-bin" },
       properties = { floating = true }, callback = awful.titlebar },
    {  rule = { class = "MPlayer",  name = "MPlayer" },
       properties = { focus = true, tag = tags[screen.count()][7], switchtotag = true }}
}
-- }}}

-- {{{ Signals
--
-- {{{ Manage signal handler
client.connect_signal("manage", function (c, startup)
    -- Add titlebar to floaters, but remove those from rule callback
    add_titlebar(c)
    if not awful.client.floating.get(c)
    and not (awful.layout.get(c.screen) == awful.layout.suit.floating) then
    awful.titlebar(c, {size=0})
    end

    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function (c)
        if  awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    -- Client placement
    if not startup then
        awful.client.setslave(c)

        if  not c.size_hints.program_position
        and not c.size_hints.user_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
     end
end)
-- }}}

-- {{{ Focus signal handlers
client.connect_signal("focus",   function (c) c.border_color = beautiful.border_focus  end)
client.connect_signal("unfocus", function (c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Arrange signal handler
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
    local clients = awful.client.visible(s)
    local layout = awful.layout.getname(awful.layout.get(s))

    for _, c in pairs(clients) do -- Floaters are always on top
        if   awful.client.floating.get(c) or layout == "floating"
        then if not c.fullscreen then c.above       =  true  end
        else                          c.above       =  false end
    end
  end)
end
-- }}}
-- }}}

exec("xset b 0 0 0")
exec("wmname LG3D")
exec("/home/andy/bin/xdbus")
-- exec("dropbox")
exec("feh --bg-scale /home/andy/pictures/wall_for_awesome_zenburn_skin_ii_by_shedied-d4xt7i6.png")
-- exec("xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 -f -n -D 7")
exec("xmodmap .xmodmap")

naughty.notify({title = "Welcome, Andy", text = "Enjoy your stay."})
