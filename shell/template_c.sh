#!/bin/sh

function template_c() {
    OUTPUT='#include <stdio.h>\n\nint main() {\n\n\tprintf("Hello, world!\\n");\n\n\treturn 0;\n}'
    echo -e $OUTPUT > "main.c"
}
