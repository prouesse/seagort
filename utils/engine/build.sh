RELEASE="--release"

if [ -z "$1" ]; then
    RELEASE=""
else
    RELEASE="--release"
fi

rustup target add x86_64-apple-darwin x86_64-unknown-linux-gnu x86_64-pc-windows-msvc

echo "" > .cargo/config

if [ `uname` == "Darwin" ]; then
    sudo launchctl start docker
elif [ `uname` == "Linux" ]; then
    sudo systemctl start docker
else
    sudo service docker start
fi

cargo build $RELEASE # Mac OSX ARM Version
cargo build $RELEASE --target=x86_64-apple-darwin # Mac OSX AMD Version

cargo build $RELEASE --target=x86_64-pc-windows-gnu # Windows

cargo build $RELEASE --target=x86_64-unknown-linux-gnu # Linux 


cbindgen --config cbindgen.toml --lang c --output libseagort.h