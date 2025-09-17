/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int top              = 0;                       /* -b option; if 0, appear at bottom */
static const char *fonts[]  = { "JetBrainsMono Nerd Font:size=12" }; /* -f option overrides fonts[0] */
static const char *prompt   = NULL;                    /* -p option; prompt to the left of input field */
static uint32_t colors[][2] = {
	/*               fg         bg          */
	[SchemeNorm] = { 0xcdcecfff, 0x1a1d21ff },
	[SchemeSel]  = { 0xeeeeeeff, 0x3b4252ff },
	[SchemeOut]  = { 0x000000ff, 0x00ffffff },
};

/* -m option; if provided, use that output instead of default output */
static const char *output_name = NULL;

/* -l option; if nonzero, use vertical list with given number of lines */
static unsigned int lines      = 10;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
