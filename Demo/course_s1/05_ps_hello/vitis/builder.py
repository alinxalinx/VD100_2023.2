# 2024-01-16T13:07:04.868119
import vitis

vitis_path = "/home/alinx/Xilinx/Vitis/2023.2"

client = vitis.create_client()
client.set_workspace(path="./")

platform = client.create_platform_component(name = "platform",hw = "./design_1_wrapper.xsa",os = "standalone",cpu = "psv_cortexa72_0")

platform = client.get_platform_component(name="platform")
domain = platform.get_domain(name="standalone_psv_cortexa72_0")

status = domain.set_lib(lib_name="lwip213", path= vitis_path+"/data/embeddedsw/ThirdParty/sw_services/lwip213_v1_1")

status = domain.set_config(option = "lib", param = "lwip213_dhcp", value = "true", lib_name="lwip213")

status = platform.build()

comp = client.create_app_component(name="hello_world",platform = "./platform/export/platform/platform.xpfm",domain = "standalone_psv_cortexa72_0",template = "hello_world")

comp = client.get_component(name="hello_world")
comp.build()

comp = client.create_app_component(name="lwip_echo_server",platform = "./platform/export/platform/platform.xpfm",domain = "standalone_psv_cortexa72_0",template = "lwip_echo_server")

comp = client.get_component(name="lwip_echo_server")
comp.build()

vitis.dispose()

