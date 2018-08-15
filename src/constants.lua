-- size of our actual window
WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

VIRTUAL_WIDTH = 1920
VIRTUAL_HEIGHT = 1080

VIRTUAL_WIDTH_2 = VIRTUAL_WIDTH / 2
VIRTUAL_HEIGHT_2 = VIRTUAL_HEIGHT / 2

-- Title State
TITLE_DELAY = 1     -- time before title fades in (seconds)
TITLE_FADE_IN = 1   -- time for title to fade in (seconds)
ENTER_DELAY = 2     -- time before enter prompt fades in (seconds)
ENTER_FADE_IN = 1   -- time for enter prompt fades in (seconds)
ENTER_PERIOD = 1    -- transparency oscilation period onf enter prompt (seconds)
SHADOW_OFFSET = 5   -- offset of shadow text (bits)

-- Selection State
SELECTIONS_START = {
    'PLAY',
    'SPECTATE',
}
MENU_TEXT_JUMP = 100

-- Player Client
HELO_FMT = 'HELO %s'




-- Colors
D = 255
FULL_COLOR = {1, 1, 1, 1}

SLATE_BLUE = {0/D, 127/D, 255/D}
COOL_BLUE = {48/D, 96/D, 130/D}