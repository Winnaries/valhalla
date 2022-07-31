srcs_pattern = "src/%s/**/*.cc"
prv_hdrs_pattern = "src/%s/**/*.h"
pub_hdrs_pattern = "valhalla/%s/**/*.h"

default_copts = [
    "-w", 
    "-I.",
    "-Ivalhalla",
    "--std=c++14", 
]

config_hdrs = [
    "valhalla/valhalla.h", 
    "valhalla/config.h",
    "valhalla/macro.h",
    "valhalla/worker.h", # Pre-included headers
]

def valhalla_test(
    name, 
    srcs = None, 
    deps = None, 
): 
    if srcs == None: 
        srcs = []

    if deps == None: 
        deps = []

    return native.cc_test(
        name = name, 
        copts = default_copts, 
        data = native.glob(["data/**/*"]), 
        srcs = srcs + native.glob(["test.*"]),
        deps = deps + [
            "@//:baldr", 
            "@//third_party:microtar",
            "@//third_party/googletest:gtest",
        ], 
    )

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
        hdrs = native.glob([pub_hdrs_pattern % name], exclude=hdrs_exclude) + config_hdrs + hdrs, 
        srcs = native.glob([srcs_pattern % name, prv_hdrs_pattern % name], exclude=srcs_exclude) + srcs, 
    )