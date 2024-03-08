# 2024-01-16T13:36:01.463908
import vitis

vitis_path = "/home/alinx/Xilinx/Vitis/2023.2"

client = vitis.create_client()
client.set_workspace(path="./")

platform = client.create_platform_component(name = "platform",hw = "./design_1_wrapper.xsa",os = "standalone",cpu = "psv_cortexa72_0")

platform = client.get_platform_component(name="platform")
domain = platform.get_domain(name="standalone_psv_cortexa72_0")

status = domain.set_lib(lib_name="lwip213", path= vitis_path+"/data/embeddedsw/ThirdParty/sw_services/lwip213_v1_1")

status = domain.set_config(option = "lib", param = "lwip213_dhcp", value = "true", lib_name="lwip213")

status = domain.set_config(option = "lib", param = "lwip213_mem_size", value = "268435456", lib_name="lwip213")

status = domain.set_config(option = "lib", param = "lwip213_memp_n_pbuf", value = "8192", lib_name="lwip213")

status = domain.set_config(option = "lib", param = "lwip213_pbuf_pool_bufsize", value = "2048", lib_name="lwip213")

status = domain.set_config(option = "lib", param = "lwip213_pbuf_pool_size", value = "4096", lib_name="lwip213")

status = platform.build()

comp = client.create_app_component(name="vdma_lcd",platform = "./platform/export/platform/platform.xpfm",domain = "standalone_psv_cortexa72_0")

comp = client.get_component(name="vdma_lcd")
status = comp.import_files(from_loc="./src", files=["vdma_lcd"], dest_dir_in_cmp = "src")

status = comp.import_files(from_loc="./src/vdma_lcd", files=["config.h", "main.c", "vdma.c", "vdma.h", "vga_modes.h", "vtc.c", "vtc.h"], dest_dir_in_cmp = "src")

status = comp.import_files(from_loc="./src/vdma_lcd", files=["CMakeLists.txt"], dest_dir_in_cmp = "src")

comp.build()


comp = client.create_app_component(name="mipi_lcd",platform = "./platform/export/platform/platform.xpfm",domain = "standalone_psv_cortexa72_0")

comp = client.get_component(name="mipi_lcd")
status = comp.import_files(from_loc="./src/mipi_lcd", files=["cam_config.c", "cam_config.h", "CMakeLists.txt", "config.h", "main.c", "vdma.c", "vdma.h", "vga_modes.h", "vtc.c", "vtc.h", "zynq_interrupt.c", "zynq_interrupt.h"], dest_dir_in_cmp = "src")

status = comp.import_files(from_loc="./src/mipi_lcd", files=["demosaic"], dest_dir_in_cmp = "src")

status = comp.import_files(from_loc="./src/mipi_lcd", files=["i2c"], dest_dir_in_cmp = "src")

comp.build()

comp = client.create_app_component(name="mipi_lwip",platform = "./platform/export/platform/platform.xpfm",domain = "standalone_psv_cortexa72_0")

comp = client.get_component(name="mipi_lwip")
status = comp.import_files(from_loc="./src/mipi_lwip", files=["cam_config.c", "cam_config.h", "CMakeLists.txt", "config.h", "display_demo.c", "i2c_access.c", "iic_phyreset.c", "lwip_app.c", "platform.c", "platform.h", "platform_config.h", "platform_mb.c", "platform_zynq.c", "platform_zynqmp.c", "sfp.c", "si5324.c", "vdma.c", "vdma.h", "vga_modes.h", "vtc.c", "vtc.h", "zynq_interrupt.c", "zynq_interrupt.h"], dest_dir_in_cmp = "src")

status = comp.import_files(from_loc="./src/mipi_lwip", files=["lscript.ld"], dest_dir_in_cmp = "src")

status = comp.import_files(from_loc="./src/mipi_lwip", files=["demosaic"], dest_dir_in_cmp = "src")

status = comp.import_files(from_loc="./src/mipi_lwip", files=["i2c"], dest_dir_in_cmp = "src")

comp.build()

vitis.dispose()

