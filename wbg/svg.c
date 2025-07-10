#include "svg.h"
#include <math.h>
#include <stdlib.h>
#include <stdio.h>

#include <nanosvg/nanosvgrast.h>

#define LOG_MODULE "svg"
#define LOG_ENABLE_DBG 0
#include "log.h"
#include "stride.h"

struct NSVGimage *svg_image = NULL;
struct NSVGrasterizer *rast = NULL;

bool
svg_load(FILE *fp, const char *path)
{
    svg_image = nsvgParseFromFile(path, "px", 96);
    if (svg_image == NULL)
        return false;
    if (svg_image->width == 0 || svg_image->height == 0) {
        LOG_DBG("%s: width and/or heigth is zero, not a SVG?", path);
        nsvgDelete(svg_image);
        svg_image = NULL;
        return false;
    }
    rast = nsvgCreateRasterizer();
    if (rast == NULL)
        return false;
    return true;
}

pixman_image_t *
svg_render(const int width, const int height, bool stretch)
{
    pixman_image_t *pix = NULL;
    uint8_t *data = NULL;
    int stride = stride_for_format_and_width(PIXMAN_a8b8g8r8, width);

    if (!(data = calloc(1, height * stride)))
        return NULL;

    double sx = width / (double)svg_image->width;
    double sy = height / (double)svg_image->height;
    double s = stretch ? fmax(sx, sy) : fmin(sx, sy);

    float tx = (width - svg_image->width * s) / 2;
    float ty = (height - svg_image->height * s) / 2;

    nsvgRasterize(rast, svg_image, tx, ty, s, data, width, height, stride);

    pix = pixman_image_create_bits_no_clear(PIXMAN_a8b8g8r8, width,
        height, (uint32_t *)data, stride);
    if (pix == NULL) {
        LOG_ERR("failed to render svg image");
        free(data);
        return NULL;
    }

    /* Copied from fuzzel */
    /* Nanosvg produces non-premultiplied ABGR, while pixman expects
     * premultiplied */
    for (uint32_t *abgr = (uint32_t *)data;
         abgr < (uint32_t *)(data + (size_t)width * (size_t)height * 4);
         abgr++) {
        uint8_t alpha = (*abgr >> 24) & 0xff;
        uint8_t blue = (*abgr >> 16) & 0xff;
        uint8_t green = (*abgr >> 8) & 0xff;
        uint8_t red = (*abgr >> 0) & 0xff;

        if (alpha == 0xff)
            continue;

        if (alpha == 0x00)
            blue = green = red = 0x00;
        else {
            blue = blue * alpha / 0xff;
            green = green * alpha / 0xff;
            red = red * alpha / 0xff;
        }

        *abgr = (uint32_t)alpha << 24 | blue << 16 | green << 8 | red;
    }

    return pix;
}

void
svg_free()
{
    if (svg_image != NULL)
        nsvgDelete(svg_image);
    if (rast != NULL)
        nsvgDeleteRasterizer(rast);
}
