#include <drm/drm_atomic_helper.h>
#include <drm/drm_crtc_helper.h>
#include <drm/drm_probe_helper.h>
#include <linux/clk.h>
#include <linux/component.h>
#include <linux/device.h>
#include <linux/of_device.h>
#include <linux/of_graph.h>
#include <linux/phy/phy.h>
#include <video/videomode.h>

#define PIXELS_PER_CLK	2

struct alinx_lcd_t {
        struct drm_encoder encoder;
        struct drm_connector connector;
        struct device *dev;

        u32 mode_flags;

        struct drm_property *sdi_mode;
        u32 sdi_mod_prop_val;
        struct drm_property *height_out;
        u32 height_out_prop_val;
        struct drm_property *width_out;
        u32 width_out_prop_val;
        struct drm_property *in_fmt;
        u32 in_fmt_prop_val;
        struct drm_property *out_fmt;
        u32 out_fmt_prop_val;
        struct drm_property *is_frac_prop;
        bool is_frac_prop_val;
        struct drm_display_mode video_mode;
};

static const struct drm_display_mode alinx_lcd_001_mode = {
    .clock = 74250,
    .hdisplay = 1280,
    .hsync_start = 1390,
    .hsync_end = 1430,
    .htotal = 1649,
    .vdisplay = 720,
    .vsync_start = 725,
    .vsync_end = 730,
    .vtotal = 749,
    .flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
    .type = 0,
    .name = "1280x720",
};

#define connector_to_sdi(c) container_of(c, struct alinx_lcd_t, connector)
#define encoder_to_sdi(e) container_of(e, struct alinx_lcd_t, encoder)

static int alinx_lcd_atomic_set_property(struct drm_connector *connector,
                             struct drm_connector_state *state,
                             struct drm_property *property, uint64_t val)
{
        struct alinx_lcd_t *sdi = connector_to_sdi(connector);
        if (property == sdi->sdi_mode)
            sdi->sdi_mod_prop_val = (unsigned int)val;
        else if (property == sdi->is_frac_prop)
            sdi->is_frac_prop_val = !!val;
        else if (property == sdi->height_out)
            sdi->height_out_prop_val = (unsigned int)val;
        else if (property == sdi->width_out)
            sdi->width_out_prop_val = (unsigned int)val;
        else if (property == sdi->in_fmt)
            sdi->in_fmt_prop_val = (unsigned int)val;
        else if (property == sdi->out_fmt)
            sdi->out_fmt_prop_val = (unsigned int)val;
        else
            return -EINVAL;
        return 0;
}

static int alinx_lcd_atomic_get_property(struct drm_connector *connector,
                             const struct drm_connector_state *state,
                             struct drm_property *property, uint64_t *val)
{
    struct alinx_lcd_t *sdi = connector_to_sdi(connector);
    if (property == sdi->sdi_mode)
        sdi->sdi_mod_prop_val = (unsigned int)val;
    else if (property == sdi->is_frac_prop)
        sdi->is_frac_prop_val = !!val;
    else if (property == sdi->height_out)
        sdi->height_out_prop_val = (unsigned int)val;
    else if (property == sdi->width_out)
        sdi->width_out_prop_val = (unsigned int)val;
    else if (property == sdi->in_fmt)
        sdi->in_fmt_prop_val = (unsigned int)val;
    else if (property == sdi->out_fmt)
        sdi->out_fmt_prop_val = (unsigned int)val;
    else
        return -EINVAL;
        return 0;
}

static int alinx_lcd_drm_add_modes(struct drm_connector *connector)
{
        int num_modes = 0;
        struct drm_display_mode *mode;
        struct drm_device *dev = connector->dev;

        mode = drm_mode_duplicate(dev, &alinx_lcd_001_mode);
        drm_mode_probed_add(connector, mode);
        num_modes++;

        return num_modes;
}

static enum drm_connector_status
alinx_lcd_detect(struct drm_connector *connector, bool force)
{
        return connector_status_connected;
}

static void alinx_lcd_connector_destroy(struct drm_connector *connector)
{
        drm_connector_unregister(connector);
        drm_connector_cleanup(connector);
        connector->dev = NULL;
}

static const struct drm_connector_funcs alinx_lcd_connector_funcs = {
        .detect = alinx_lcd_detect,
        .fill_modes = drm_helper_probe_single_connector_modes,
        .destroy = alinx_lcd_connector_destroy,
        .atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
        .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
        .reset = drm_atomic_helper_connector_reset,
        .atomic_set_property = alinx_lcd_atomic_set_property,
        .atomic_get_property = alinx_lcd_atomic_get_property,
};

static struct drm_encoder *
alinx_lcd_best_encoder(struct drm_connector *connector)
{
        return &(connector_to_sdi(connector)->encoder);
}

static int alinx_lcd_get_modes(struct drm_connector *connector)
{
        return alinx_lcd_drm_add_modes(connector);
}

static struct drm_connector_helper_funcs alinx_lcd_connector_helper_funcs = {
        .get_modes = alinx_lcd_get_modes,
        .best_encoder = alinx_lcd_best_encoder,
};

static void alinx_lcd_drm_connector_create_property(struct drm_connector *base_connector)
{
    struct drm_device *dev = base_connector->dev;
    struct alinx_lcd_t *sdi  = connector_to_sdi(base_connector);

    sdi->is_frac_prop = drm_property_create_bool(dev, 0, "is_frac");
    sdi->sdi_mode = drm_property_create_range(dev, 0, "sdi_mode", 0, 5);
    sdi->height_out = drm_property_create_range(dev, 0, "height_out", 2, 4096);
    sdi->width_out = drm_property_create_range(dev, 0, "width_out", 2, 4096);
    sdi->in_fmt = drm_property_create_range(dev, 0, "in_fmt", 0, 16384);
    sdi->out_fmt = drm_property_create_range(dev, 0, "out_fmt", 0, 16384);
}

static void alinx_lcd_drm_connector_attach_property(struct drm_connector *base_connector)
{
    struct alinx_lcd_t *sdi = connector_to_sdi(base_connector);
    struct drm_mode_object *obj = &base_connector->base;

    if (sdi->sdi_mode)
        drm_object_attach_property(obj, sdi->sdi_mode, 0);

    if (sdi->is_frac_prop)
        drm_object_attach_property(obj, sdi->is_frac_prop, 0);

    if (sdi->height_out)
        drm_object_attach_property(obj, sdi->height_out, 0);

    if (sdi->width_out)
        drm_object_attach_property(obj, sdi->width_out, 0);

    if (sdi->in_fmt)
        drm_object_attach_property(obj, sdi->in_fmt, 0);

    if (sdi->out_fmt)
        drm_object_attach_property(obj, sdi->out_fmt, 0);
}

static int alinx_lcd_create_connector(struct drm_encoder *encoder)
{
        struct alinx_lcd_t *sdi = encoder_to_sdi(encoder);
        struct drm_connector *connector = &sdi->connector;
        int ret;

        connector->interlace_allowed = true;
        connector->doublescan_allowed = true;

        ret = drm_connector_init(encoder->dev, connector,
                                 &alinx_lcd_connector_funcs,
                                 DRM_MODE_CONNECTOR_Unknown);
        if (ret) {
                dev_err(sdi->dev, "Failed to initialize connector with drm\n");
                return ret;
        }

        drm_connector_helper_add(connector, &alinx_lcd_connector_helper_funcs);
        drm_connector_register(connector);
        drm_connector_attach_encoder(connector, encoder);
        alinx_lcd_drm_connector_create_property(connector);
        alinx_lcd_drm_connector_attach_property(connector);

        return 0;
}

static void alinx_lcd_encoder_atomic_mode_set(struct drm_encoder *encoder, 
                                              struct drm_crtc_state *crtc_state, 
                                              struct drm_connector_state *connector_state)
{
        struct alinx_lcd_t *sdi = encoder_to_sdi(encoder);
        struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
        struct videomode vm;
        u32 sditx_blank, vtc_blank;

        vm.hactive = adjusted_mode->hdisplay / PIXELS_PER_CLK;
        vm.hfront_porch = (adjusted_mode->hsync_start - adjusted_mode->hdisplay) / PIXELS_PER_CLK;
        vm.hback_porch = (adjusted_mode->htotal - adjusted_mode->hsync_end) / PIXELS_PER_CLK;
        vm.hsync_len = (adjusted_mode->hsync_end - adjusted_mode->hsync_start) / PIXELS_PER_CLK;

        vm.vactive = adjusted_mode->vdisplay;
        vm.vfront_porch = adjusted_mode->vsync_start - adjusted_mode->vdisplay;
        vm.vback_porch = adjusted_mode->vtotal - adjusted_mode->vsync_end;
        vm.vsync_len = adjusted_mode->vsync_end - adjusted_mode->vsync_start;
        vm.flags = 0;
        if (adjusted_mode->flags & DRM_MODE_FLAG_INTERLACE)
                vm.flags |= DISPLAY_FLAGS_INTERLACED;
        if (adjusted_mode->flags & DRM_MODE_FLAG_PHSYNC)
                vm.flags |= DISPLAY_FLAGS_HSYNC_LOW;
        if (adjusted_mode->flags & DRM_MODE_FLAG_PVSYNC)
                vm.flags |= DISPLAY_FLAGS_VSYNC_LOW;

        do {
                sditx_blank = (adjusted_mode->hsync_start -
                               adjusted_mode->hdisplay) +
                              (adjusted_mode->hsync_end -
                               adjusted_mode->hsync_start) +
                              (adjusted_mode->htotal -
                               adjusted_mode->hsync_end);

                vtc_blank = (vm.hfront_porch + vm.hback_porch +
                             vm.hsync_len) * PIXELS_PER_CLK;

                if (vtc_blank != sditx_blank)
                        vm.hfront_porch++;
        } while (vtc_blank < sditx_blank);

        vm.pixelclock = adjusted_mode->clock * 1000;

        sdi->video_mode.vdisplay = adjusted_mode->vdisplay;
        sdi->video_mode.hdisplay = adjusted_mode->hdisplay;
        sdi->video_mode.flags = adjusted_mode->flags;
}

static void alinx_lcd_commit(struct drm_encoder *encoder)
{
        struct alinx_lcd_t *sdi = encoder_to_sdi(encoder);
}

static void alinx_lcd_disable(struct drm_encoder *encoder)
{
        struct alinx_lcd_t *sdi = encoder_to_sdi(encoder);
}

static const struct drm_encoder_helper_funcs alinx_lcd_encoder_helper_funcs = {
        .atomic_mode_set	= alinx_lcd_encoder_atomic_mode_set,
        .enable			= alinx_lcd_commit,
        .disable		= alinx_lcd_disable,
};

static const struct drm_encoder_funcs alinx_lcd_encoder_funcs = {
        .destroy = drm_encoder_cleanup,
};

static int alinx_lcd_bind(struct device *dev, struct device *master,
                         void *data)
{
        struct alinx_lcd_t *sdi = dev_get_drvdata(dev);
        struct drm_encoder *encoder = &sdi->encoder;
        struct drm_device *drm_dev = data;
        int ret;

        encoder->possible_crtcs = 1;

        drm_encoder_init(drm_dev, encoder, &alinx_lcd_encoder_funcs,
                         DRM_MODE_ENCODER_TMDS, NULL);

        drm_encoder_helper_add(encoder, &alinx_lcd_encoder_helper_funcs);

        ret = alinx_lcd_create_connector(encoder);
        if (ret) {
                dev_err(sdi->dev, "fail creating connector, ret = %d\n", ret);
                drm_encoder_cleanup(encoder);
        }
        return ret;
}

static void alinx_lcd_unbind(struct device *dev, struct device *master,
                            void *data)
{
        struct alinx_lcd_t *sdi = dev_get_drvdata(dev);

        drm_encoder_cleanup(&sdi->encoder);
        drm_connector_cleanup(&sdi->connector);
}

static const struct component_ops alinx_lcd_component_ops = {
        .bind	= alinx_lcd_bind,
        .unbind	= alinx_lcd_unbind,
};

static int alinx_lcd_probe(struct platform_device *pdev)
{
        struct device *dev = &pdev->dev;
        struct alinx_lcd_t *sdi;
        int ret;
        struct device_node *ports, *port;
        u32 nports = 0, portmask = 0;

        sdi = devm_kzalloc(dev, sizeof(*sdi), GFP_KERNEL);
        if (!sdi)
                return -ENOMEM;

        sdi->dev = dev;

        platform_set_drvdata(pdev, sdi);

        ports = of_get_child_by_name(sdi->dev->of_node, "ports");
        if (!ports) {
                dev_dbg(dev, "Searching for port nodes in device node.\n");
                ports = sdi->dev->of_node;
        }

        for_each_child_of_node(ports, port) {
                struct device_node *endpoint;
                u32 index;

                if (!port->name || of_node_cmp(port->name, "port")) {
                        dev_dbg(dev, "port name is null or node name is not port!\n");
                        continue;
                }

                endpoint = of_get_next_child(port, NULL);
                if (!endpoint) {
                        dev_err(dev, "No remote port at %s\n", port->name);
                        of_node_put(endpoint);
                        ret = -EINVAL;
                        return ret;
                }

                of_node_put(endpoint);

                ret = of_property_read_u32(port, "reg", &index);
                if (ret) {
                        dev_err(dev, "reg property not present - %d\n", ret);
                        return ret;
                }

                portmask |= (1 << index);

                nports++;
        }

        if (nports == 1 && portmask & 0x1) {
                dev_dbg(dev, "no ancillary port\n");
        } else {
                dev_err(dev, "Incorrect dt node!\n");
                ret = -EINVAL;
                return ret;
        }

        pdev->dev.platform_data = &sdi->video_mode;

        ret = component_add(dev, &alinx_lcd_component_ops);

        return ret;
}

static int alinx_lcd_remove(struct platform_device *pdev)
{
        component_del(&pdev->dev, &alinx_lcd_component_ops);

        return 0;
}

static const struct of_device_id alinx_lcd_of_match[] = {
        { .compatible = "ax-drm-encoder"},
        { }
};
MODULE_DEVICE_TABLE(of, alinx_lcd_of_match);

static struct platform_driver sdi_tx_driver = {
        .probe = alinx_lcd_probe,
        .remove = alinx_lcd_remove,
        .driver = {
                .name = "alinx-lcd-001",
                .of_match_table = alinx_lcd_of_match,
        },
};

module_platform_driver(sdi_tx_driver);

MODULE_DESCRIPTION("alinx lcd driver");
MODULE_LICENSE("GPL v2");
