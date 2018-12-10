BUILD_DEPENDS=(liborbital mesa mesa_glu)

function recipe_version {
    printf "1.0.0"
    skip=1
}

function recipe_update {
    echo "skipping update"
    skip=1
}

function recipe_build {
    cp ../osdemo.c osdemo.c
    sysroot="${PWD}/../sysroot"
    set -x
    "${CXX}" -I "$sysroot/include" -L "$sysroot/lib" osdemo.c -o osdemo -lorbital -lOSMesa -lGLU -lglapi -Wl,--whole-archive -lpthread -Wl,--no-whole-archive -lm
    set +x
    skip=1
}

function recipe_test {
    echo "skipping test"
    skip=1
}

function recipe_clean {
    make clean
    skip=1
}

function recipe_stage {
    dest="$(realpath $1)"
    mkdir -pv "$dest/bin"
    cp -v "osdemo" "$dest/bin/osdemo"
    skip=1
}