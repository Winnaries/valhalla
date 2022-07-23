srcs_pattern = "src/%s/**/*.cc"
srcs_headers = "src/%s/**/*.h"
hdrs_pattern = "valhalla/**/*.h"

default_copts = [
    "-I.", 
    "-Ivalhalla", 
    "--std=c++14", 
    "-Wno-unused-variable", 
]

def valhalla_library(
    name,
    hdrs = None,
    srcs = None,
    deps = None, 
    copts = None,
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

    return native.cc_library(
        name = name, 
        deps = deps, 
        visibility = visibility, 
        copts = default_copts + copts, 
        srcs = native.glob([srcs_pattern % name]) + srcs, 
        hdrs = native.glob([hdrs_pattern, srcs_headers % name]) + hdrs, 
    )