GIT=https://github.com/redox-os/dash.git
BRANCH=redox

HOST=x86_64-elf-redox
export AR="${HOST}-ar"
export AS="${HOST}-as"
export CC="${HOST}-gcc"
export CXX="${HOST}-g++"
export LD="${HOST}-ld"
export NM="${HOST}-nm"
export OBJCOPY="${HOST}-objcopy"
export OBJDUMP="${HOST}-objdump"
export RANLIB="${HOST}-ranlib"
export READELF="${HOST}-readelf"
export STRIP="${HOST}-strip"

function recipe_version {
    printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
    return 1
}

function recipe_update {
    echo "skipping update"
    return 1
}

function recipe_build {
    ./autogen.sh
    ./configure --host=${HOST} --prefix=/
    make
    return 1
}

function recipe_test {
    echo "skipping test"
    return 1
}

function recipe_clean {
    make clean
    return 1
}

function recipe_stage {
    dest="$(realpath $1)"
    make DESTDIR="$dest" install
    return 1
}
