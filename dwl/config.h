/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }
/* appearance */
static const int sloppyfocus               = 1;  /* focus follows mouse */
static const int bypass_surface_visibility = 0;  /* 1 means idle inhibitors will disable idle tracking even if it's surface isn't visible  */
static const unsigned int borderpx         = 2;  /* border pixel of windows */
static const float rootcolor[]             = COLOR(0x222222ff);
static const float bordercolor[]           = COLOR(0x444444ff);
static const float focuscolor[]            = COLOR(0xbf616aff);
static const float urgentcolor[]           = COLOR(0xff0000ff);
/* This conforms to the xdg-protocol. Set the alpha to zero to restore the old behavior */
static const float fullscreen_bg[]         = {0.1f, 0.1f, 0.1f, 1.0f}; /* You can also use glsl colors */

/* tagging - TAGCOUNT must be no greater than 31 */
#define TAGCOUNT (10)

/* logging */
static int log_level = WLR_ERROR;

/* NOTE: ALWAYS keep a rule declared even if you don't use rules (e.g leave at least one example) */
static const Rule rules[] = {
	/* app_id             title       tags mask     isfloating     monitor */
	{ "firefox",          NULL,       1 << 0,       0,             -1 }, 
	{ "Zotero",           NULL,       1 << 4,       0,             -1 }, 
	{ "zathura",          NULL,       1 << 5,       0,             -1 }, 
	{ "mpv",              NULL,       1 << 6,       0,             -1 }, 
	{ "signal-desktop",   NULL,       1 << 7,       0,             -1 }, 
	{ "thunderbird",      NULL,       1 << 8,       0,             -1 }, 
};

/* layout(s) */
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* monitors */
/* (x=-1, y=-1) is reserved as an "autoconfigure" monitor position indicator
 * WARNING: negative values other than (-1, -1) cause problems with Xwayland clients
 * https://gitlab.freedesktop.org/xorg/xserver/-/issues/899
*/
/* NOTE: ALWAYS add a fallback rule, even if you are completely sure it won't be used */
static const MonitorRule monrules[] = {
	/* name       mfact  nmaster scale layout       rotate/reflect                x    y */
	/* example of a HiDPI laptop monitor:
	{ "eDP-1",    0.5f,  1,      2,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 },
	*/
	/* defaults */
	{ NULL,       0.55f, 1,      1,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 },
};

/* keyboard */
static const struct xkb_rule_names xkb_rules = {
	/* can specify fields: rules, model, layout, variant, options */
	/* example:
	.options = "ctrl:nocaps",
	*/
    .layout = "be",
	.options = NULL,
};

/* numlock and capslock */
static const int numlock = 1;
static const int capslock = 0;

static const int repeat_rate = 50;
static const int repeat_delay = 300;

/* Trackpad */
static const int tap_to_click = 1;
static const int tap_and_drag = 1;
static const int drag_lock = 1;
static const int natural_scrolling = 0;
static const int disable_while_typing = 1;
static const int left_handed = 0;
static const int middle_button_emulation = 0;
/* You can choose between:
LIBINPUT_CONFIG_SCROLL_NO_SCROLL
LIBINPUT_CONFIG_SCROLL_2FG
LIBINPUT_CONFIG_SCROLL_EDGE
LIBINPUT_CONFIG_SCROLL_ON_BUTTON_DOWN
*/
static const enum libinput_config_scroll_method scroll_method = LIBINPUT_CONFIG_SCROLL_2FG;

/* You can choose between:
LIBINPUT_CONFIG_CLICK_METHOD_NONE
LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS
LIBINPUT_CONFIG_CLICK_METHOD_CLICKFINGER
*/
static const enum libinput_config_click_method click_method = LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS;

/* You can choose between:
LIBINPUT_CONFIG_SEND_EVENTS_ENABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED_ON_EXTERNAL_MOUSE
*/
static const uint32_t send_events_mode = LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;

/* You can choose between:
LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT
LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE
*/
static const enum libinput_config_accel_profile accel_profile = LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE;
static const double accel_speed = 0.0;

/* You can choose between:
LIBINPUT_CONFIG_TAP_MAP_LRM -- 1/2/3 finger tap maps to left/right/middle
LIBINPUT_CONFIG_TAP_MAP_LMR -- 1/2/3 finger tap maps to left/middle/right
*/
static const enum libinput_config_tap_button_map button_map = LIBINPUT_CONFIG_TAP_MAP_LRM;

/* If you want to use the windows key for MODKEY, use WLR_MODIFIER_LOGO */
#define MODKEY WLR_MODIFIER_LOGO

#define TAGKEYS(KEY,SKEY,TAG) \
	{ MODKEY,                    -1, KEY,            view,            {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL,  -1, KEY,            toggleview,      {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_SHIFT, -1, SKEY,           tag,             {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL|WLR_MODIFIER_SHIFT,-1,SKEY,toggletag,  {.ui = 1 << TAG} }

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *termcmd[] = { "foot", NULL };
static const char *menucmd[] = { "fuzzel", NULL };
static const char *screenshot_select[] = { "screenshot_select", NULL };
static const char *screenshot_full[] = { "screenshot_full", NULL };
static const char *brightness_up[] = { "brightnessctl", "set", "5%+", NULL };
static const char *brightness_down[] = { "brightnessctl", "set", "5%-", NULL };

static const char *volume_up[] = { "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+", NULL };
static const char *volume_down[] = { "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-", NULL };
static const char *volume_mute[] = { "wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle", NULL };
static const char *audio_toggle[] = { "playerctl", "play-pause", NULL };
static const char *audio_next[] = { "playerctl", "next", NULL };
static const char *audio_prev[] = { "playerctl", "previous", NULL };

static const char *networkmanager_dmenu[] = { "networkmanager_dmenu", NULL };
static const char *dmenu_bluetooth[] = { "launch_bluetooth", NULL };
static const char *cliphist[] = { "launch_cliphist", NULL };
static const char *pavucontrol[] = { "pavucontrol", NULL };

static const char *poweroff[] = { "poweroff", NULL };
static const char *reboot[] = { "systemctl", "reboot", NULL };
static const char *suspend[] = { "systemctl", "suspend", NULL };
static const char *lock_session[] = { "swaylock", NULL };

static const Key keys[] = {
	/* Note that Shift changes certain key codes: c -> C, 2 -> at, etc. */
	/* modifier                  chain,  key                 function        argument */
	{ MODKEY,                    -1, XKB_KEY_d,          spawn,          {.v = menucmd} },
	{ MODKEY,                    -1, XKB_KEY_Return,     spawn,          {.v = termcmd} },
	{ MODKEY,                    -1, XKB_KEY_b,          toggletag,      {0} },
	{ MODKEY,                    XKB_KEY_s, XKB_KEY_s,   spawn,          {.v = screenshot_select} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_s, XKB_KEY_f,   spawn,          {.v = screenshot_full} },
    { MODKEY|WLR_MODIFIER_SHIFT, -1, XKB_KEY_W,          spawn,          {.v = networkmanager_dmenu} },
    { MODKEY|WLR_MODIFIER_SHIFT, -1, XKB_KEY_B,          spawn,          {.v = dmenu_bluetooth} },
    { MODKEY,                    -1, XKB_KEY_u,          spawn,          {.v = cliphist} },
    { MODKEY,                    -1, XKB_KEY_p,          spawn,          {.v = pavucontrol} },

	{ 0, -1, XKB_KEY_XF86MonBrightnessUp,                spawn,          {.v = brightness_up} },
	{ 0, -1, XKB_KEY_XF86MonBrightnessDown,              spawn,          {.v = brightness_down} },
	{ 0, -1, XKB_KEY_XF86AudioRaiseVolume,               spawn,          {.v = volume_up} },
	{ 0, -1, XKB_KEY_XF86AudioLowerVolume,               spawn,          {.v = volume_down} },
	{ 0, -1, XKB_KEY_XF86AudioMute,                      spawn,          {.v = volume_mute} },
	{ 0, -1, XKB_KEY_XF86AudioPlay,                      spawn,          {.v = audio_toggle} },
	{ 0, -1, XKB_KEY_XF86AudioNext,                      spawn,          {.v = audio_next} },
	{ 0, -1, XKB_KEY_XF86AudioPrev,                      spawn,          {.v = audio_prev} },

	{ MODKEY,                    -1, XKB_KEY_j,          focusstack,     {.i = +1} },
	{ MODKEY,                    -1, XKB_KEY_k,          focusstack,     {.i = -1} },
	// { MODKEY,                    -1, XKB_KEY_i,          incnmaster,     {.i = +1} },
	// { MODKEY|WLR_MODIFIER_SHIFT, -1, XKB_KEY_I,          incnmaster,     {.i = -1} },
	{ MODKEY,                    -1, XKB_KEY_h,          setmfact,       {.f = -0.05f} },
	{ MODKEY,                    -1, XKB_KEY_l,          setmfact,       {.f = +0.05f} },
	{ MODKEY|WLR_MODIFIER_SHIFT, -1, XKB_KEY_Return,     zoom,           {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, -1, XKB_KEY_Tab,        view,           {0} },
	{ MODKEY,                    -1, XKB_KEY_q,          killclient,     {0} },
	{ MODKEY,                    -1, XKB_KEY_t,          setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                    -1, XKB_KEY_e,          setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                    -1, XKB_KEY_m,          setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                    -1, XKB_KEY_space,      setlayout,      {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, -1, XKB_KEY_space,      togglefloating, {0} },
	{ MODKEY,                    -1, XKB_KEY_f,         togglefullscreen, {0} },
	{ MODKEY,                    -1, XKB_KEY_0,          view,           {.ui = ~0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, -1, XKB_KEY_parenright, tag,            {.ui = ~0} },
	{ MODKEY,                    -1, XKB_KEY_comma,      focusmon,       {.i = WLR_DIRECTION_LEFT} },
	{ MODKEY,                    -1, XKB_KEY_period,     focusmon,       {.i = WLR_DIRECTION_RIGHT} },
	{ MODKEY|WLR_MODIFIER_SHIFT, -1, XKB_KEY_less,       tagmon,         {.i = WLR_DIRECTION_LEFT} },
	{ MODKEY|WLR_MODIFIER_SHIFT, -1, XKB_KEY_greater,    tagmon,         {.i = WLR_DIRECTION_RIGHT} },

	TAGKEYS( XKB_KEY_ampersand,  XKB_KEY_1,                          0),
	TAGKEYS( XKB_KEY_eacute,     XKB_KEY_2,                          1),
	TAGKEYS( XKB_KEY_quotedbl,   XKB_KEY_3,                          2),
	TAGKEYS( XKB_KEY_apostrophe, XKB_KEY_4,                          3),
	TAGKEYS( XKB_KEY_parenleft,  XKB_KEY_5,                          4),
	TAGKEYS( XKB_KEY_section,    XKB_KEY_6,                          5),
	TAGKEYS( XKB_KEY_egrave,     XKB_KEY_7,                          6),
	TAGKEYS( XKB_KEY_exclam,     XKB_KEY_8,                          7),
	TAGKEYS( XKB_KEY_ccedilla,   XKB_KEY_9,                          8),
    
    { MODKEY|WLR_MODIFIER_SHIFT,                    XKB_KEY_P,              XKB_KEY_p,          spawn,           {.v = poweroff} },
	{ MODKEY|WLR_MODIFIER_SHIFT,                    XKB_KEY_P,              XKB_KEY_r,          spawn,           {.v = reboot} },
	{ MODKEY|WLR_MODIFIER_SHIFT,                    XKB_KEY_P,              XKB_KEY_s,          spawn,           {.v = suspend} },
	{ MODKEY|WLR_MODIFIER_SHIFT,                    XKB_KEY_P,              XKB_KEY_l,          spawn,           {.v = lock_session} },
	{ MODKEY|WLR_MODIFIER_SHIFT,                    XKB_KEY_P,              XKB_KEY_o,          quit,           {0} },

	/* Ctrl-Alt-Backspace and Ctrl-Alt-Fx used to be handled by X server */
	{ WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,-1,XKB_KEY_Terminate_Server, quit, {0} },
	/* Ctrl-Alt-Fx is used to switch to another VT, if you don't know what a VT is
	 * do not remove them.
	 */
#define CHVT(n) { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,-1,XKB_KEY_XF86Switch_VT_##n, chvt, {.ui = (n)} }
	CHVT(1), CHVT(2), CHVT(3), CHVT(4), CHVT(5), CHVT(6),
	CHVT(7), CHVT(8), CHVT(9), CHVT(10), CHVT(11), CHVT(12),
};

static const Button buttons[] = {
	{ MODKEY, BTN_LEFT,   moveresize,     {.ui = CurMove} },
	// { MODKEY, BTN_MIDDLE, togglefloating, {0} },
	{ MODKEY, BTN_RIGHT,  moveresize,     {.ui = CurResize} },
};
