# pretty much the same as here
# https://github.com/polybar/polybar/wiki/Compiling

# I had first to set my python to use the system one :-p
# asdf global python system

STEP=1

function step {
    echo "------------"
    echo $STEP $1
    echo "------------"
    ((STEP=$STEP+1))
}

function install_deps {
    step "About to install dependencies"

    sudo apt install build-essential git cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev

}

function install_optional_deps {
    step  "About to install optional dependencies"
    sudo apt install libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev
}


# needed to checkout things in /lib folder
function init_submodules {
    step  "Checkout submodules"
    git submodule init && \
    git submodule update
}

function build_polybar {
    step  "About to build polybar"
    rm -rf build
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc)
}


function install {
    step  "About to install polybar"
    sudo make install
}

install_deps && install_optional_deps && init_submodules && \
build_polybar && install
