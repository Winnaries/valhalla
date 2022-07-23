srcs_pattern = "src/%s/**/*.cc"
srcs_headers = "src/%s/**/*.h"
hdrs_pattern = "valhalla/**/*.h"

default_copts = [
    "-w", 
    "-I.",
    "-Ivalhalla",
    "--std=c++14", 
]

def valhalla_library(
    name,
    hdrs = None,
    srcs = None,
    deps = None, 
    copts = None,
    srcs_exclude = None, 
    hdrs_exclude = None, 
    visibility = ["//visibility:public"]
): 
    if deps == None: 
        deps = []

    if hdrs == None: 
        hdrs = []

    if srcs == None: 
        srcs = []

    if copts == None: 
        copts = []

    if srcs_exclude == None: 
        srcs_exclude = []

    if hdrs_exclude == None: 
        hdrs_exclude = []

    return native.cc_library(
        name = name, 
        deps = deps, 
        visibility = visibility, 
        copts = default_copts + copts, 
        srcs = native.glob([srcs_pattern % name], exclude=srcs_exclude) + srcs, 
        hdrs = native.glob([hdrs_pattern, srcs_headers % name], exclude=hdrs_exclude) + hdrs, 
    )